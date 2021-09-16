Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9D140D97D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbhIPMKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 08:10:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2346 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239155AbhIPMKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:10:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GBLCHk029263;
        Thu, 16 Sep 2021 12:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MP2a5+SYmKEe3zr2Pkqez+KyBFIAllITcJx9n+vGvhI=;
 b=FVmE+ajzkW91upkrGRXkqTB3j1aYqprrvZJqXwCpm3uOcYHtUFYllFV9PaLePmG+J2Rh
 6hktVpx2E1figWIhPnf46eb7rDNmLgkMt7pdCD8TIKdiQAX0v2c84xvOkOUnbolM+IsC
 FA6mj/ghfh3VhhepF8BS43D/86zeeRGjzgm0JlULMpD3j3d+QbNAUOoXI7cJNFe+Vn2o
 mFpGIGOHSi55NavSZdupTDgj0Cch4G/UFsrjyRT1I+0o/zWOfQc/TNU66qnjycGIt4nU
 Qlo33T8d9UN4pLFVseaZurZG91TsXrkNY0PHgS5Y5w+KbE0Ach0Ytwpx6eMIXgHeYNID YQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MP2a5+SYmKEe3zr2Pkqez+KyBFIAllITcJx9n+vGvhI=;
 b=sLgrvXNKkd+P+H2QhJYmxEgan5sSJpRNCnCbLqcUWWSCpiblEU+cWAerbu5Sm23z6rta
 Tm3mCfCs/E9jVBwhMXWA0sXLQXEBxDbdBQYRogQlOOMTmaqhRwLzvbdah22SnNGkSJS5
 GSGb3drz8j9bPhxQu8519UHUHCu0pRdFJTwdGVc3NKZVEp354FaMl1OBU7V+I/YuaZtu
 jLboazXqdhBU/naawZ5OBbnarP7Ey5aoZrDMx/6gWMkd/CQEbA6UN1T+ynF8TJJa5V3A
 ndl/17zqwIWWUqPRLmZY+0kk80AhlU6q6Y7mxxBqIDIMH5hS7ZXayjMCNPudiN/3DJZN Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3tnhsrnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:08:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GC6V9B157903;
        Thu, 16 Sep 2021 12:08:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3b0m997h04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 12:08:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeOxpD9uwMebVZVHxMJ5JhuT3JzV8IL4rtkBsOLfGBaj3sVvhavYEQyPnYIiSXv2DUCm26F66Mg7mhOeti8kqRIzJfCoRgjjtekfbSS6khDIOm6ZguXDvJSRzzxtY4lnGonU3ADiiclA5RVcU9dWrFoArIs6jCfwaomZGngG0njdLU/NVlIi3sIo5rwnkQWvvNl6YywG+YdbfuLNk6em1DRfzmFeAkI2micM1OK898LEZhpaVpq71wNWW6SOkJ+Vug3n0Ba+NKWy5ZizYO9qwrctSBTkE/TyDNQZIfnPhlGpJ8zP2NUvZ/pW6vIh02h9pqIJpM9YjSv6nX3qEAdqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MP2a5+SYmKEe3zr2Pkqez+KyBFIAllITcJx9n+vGvhI=;
 b=i0Bu1fwgTCQJQVeFWl9yAifxCjta8NA06N/yRdVAFcQdL8CRURLR0PhuXUSC6Jr3wslHyIzGlIgEbkOiVzHWDAxiL6TXlibu3vWFFgjNAz0vPMroNjx6YnqvDO+je54FfvcqN8xEEmSXtLx4XW5kXvPKpaY2eZ8IlD9vBZAUccLJNXc8ZvWPS8xDZRQ8+p7AfnHkelVnTDkCct1eQK8a2BoJ36bC8B3TrqBdkbBXaxCc0PVOHn/pjh7tvqUKOzfBgidHsEOHjSP4EHD/t+VBkrV0kv81ZRdnWYfB7INt+bj9O+yy9f7V6v+4H3ipvJPI1rd2BT70NtV+P1o1cfOTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP2a5+SYmKEe3zr2Pkqez+KyBFIAllITcJx9n+vGvhI=;
 b=quQPoQyWyS31yDH0bmqKFi/GRehFuFEg9yetCPwmmzSIcwbny0V1ZUm4r3+NiSXPsDDKluWnXSE17A0Jr/sY7Na19/oC79abhohV0w2nxKjR94CiDRdimh8DYhI0XnbviYJTMw1Io8yCKLFC4cmJnJVlnwjcrN9swRaaXZvxYpU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SA2PR10MB4587.namprd10.prod.outlook.com (2603:10b6:806:114::12)
 by SA2PR10MB4620.namprd10.prod.outlook.com (2603:10b6:806:fb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 12:08:50 +0000
Received: from SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::1138:f2cb:64f8:c901]) by SA2PR10MB4587.namprd10.prod.outlook.com
 ([fe80::1138:f2cb:64f8:c901%9]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 12:08:49 +0000
References: <20210916013916.GD34899@magnolia>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Chandan Babu R <chandan.babu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] : Shameless plug for the FS Track at LPC next week!
In-reply-to: <20210916013916.GD34899@magnolia>
Message-ID: <87ilz0afjt.fsf@debian-BULLSEYE-live-builder-AMD64>
Date:   Thu, 16 Sep 2021 17:38:38 +0530
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::14) To SA2PR10MB4587.namprd10.prod.outlook.com
 (2603:10b6:806:114::12)
MIME-Version: 1.0
Received: from nandi (122.171.167.196) by MAXPR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 12:08:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5eb134f-a7db-45bd-4241-08d9790abe05
X-MS-TrafficTypeDiagnostic: SA2PR10MB4620:
X-Microsoft-Antispam-PRVS: <SA2PR10MB46209547367AAE5E80C21E1EF6DC9@SA2PR10MB4620.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TWInQ9JU2pg8sfW18tNIo/U6axlKwUCJezAio/kJb1v/QHk+CyxbyyssJq2OEB+D+ddd7SDugQIdqV1ypIDrwxuaIiC5eiTH1mghcXrvoVojPLb8kYKsF75R+sU0lD+hXPreSkgothlmMmy6tXk84BAa+/aov0LWHwivQ1AAOfgcU6+BgOqDdw/hzhnJtD1LRxAeTMNMpikzTpusOrN8VDCh9YuZkZutblolq5UNNEhVyQyM2XLIXGqQhiVKYU6WmPKHJc6wk3cWWctq4I0JQF/xTb//0irba3BvAYWn6BbOzFdIdqHIqv+IKonR+F+X039qRICqsgW9K86VON1mB4ZvU7wSfk4goY2/aZhPVBXOwPrjIQVg/4OYN1+4GJ8n7ugWwgxfwIWsRg8cHB/nkgQKJCqm5xIaEUw4Y23fbIt2CUiKMWTpVRAxxtw65qgf5Ly8LHMUPZrWVrCblSt1RTfPHIUpSMl2nfOfS6+FulQmqFLo1hJyHupda/UlLlyDJIgEYAAX5roGmEQhzpKWPBWIsn02BeUEvTbAf5mC/yNLC9NKRTypIPbdySYGN9OuuyI3Li3txQkaDnDusc6m0eCRpDqPdh2vBX71H84BBW356CW8EoyyyJiThLWR3tPEJD+kNHayzdXk50ZT2QP4/MwMa2cK+qfQEn/sHxzjF9PX2dpAACnqrs2eTtZgE/DEiPzQsvtSh2evrtObXy2Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4587.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(186003)(8936002)(8676002)(66556008)(83380400001)(66476007)(6916009)(4326008)(86362001)(52116002)(9686003)(6496006)(316002)(508600001)(4744005)(6666004)(2906002)(54906003)(26005)(6486002)(5660300002)(38350700002)(66946007)(38100700002)(33716001)(956004)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yuWOOdLhYT36IIyKCEEB0B+NakggeuPlsF3w2bKXaOrQVwobQhgnUm+Etzlz?=
 =?us-ascii?Q?oF7QjMhLaOVXf+Hm1VxMZZFQs1nzaHHlW4nA0DCm+I5MLzF2/3UdSCB5wxE1?=
 =?us-ascii?Q?TRsgPssHv9Rx1AUDRMgfXfgVNvHoY8BfVJwtLFfRd2Q50eh7o56w2m/zvSP0?=
 =?us-ascii?Q?TwviVHt0KSwV/PUIm0yootLj9LEKox17L6AbzURR+O6zDZf3XSD9UzxsDfO+?=
 =?us-ascii?Q?lYvJQMTebR7PYvdtx/TZ/QTBBtxL4mpVtTYPhhTrqQxUsylGPE+LLa48Pxdm?=
 =?us-ascii?Q?X9rfajA8AFl5WzDUlYPtI4K0hJ4KyJ82+bLOoVJDPcFt2TIFMlND8nsPWswI?=
 =?us-ascii?Q?Rrg4ajzEcAIdE2lBoPzK3n7qp1ykrOm/8nWwW3I6daeyS2HO2UJKPT8Y8f8e?=
 =?us-ascii?Q?jEiqernI6IOrfQ07gSDx1+rFMdDNVwhc9pRdHdYBeqBH8y6V3zXmjKel/XoP?=
 =?us-ascii?Q?N8HM9afXnlFbMtBZAgyCJ3MXfW/BC/UNrpXvwYJu+SL9PyL1dWsrGw/m+N9E?=
 =?us-ascii?Q?MRMc5EMc8QZWlgMCIt/ERpi+nnzun+Hu2Yy8A7zHuD4iSqYFR0uTe/vNkZoL?=
 =?us-ascii?Q?Vim0fmuEDq0mXFVCbrNI0qgEnxhBWABdkb+Mlpza4Y/B5xaxZiIrAj1nKYy7?=
 =?us-ascii?Q?QSeGXJLGh6Atnp46DcA6ERVrIEAb7CVFA4RLRbv0Ox+lP4wBGyIbtiJJvzJJ?=
 =?us-ascii?Q?T5bXriy6PgcfWv9UJZOB/mfcD2JJUMKd/S35nWEA6/2DjdjcGpsxfoTzEd2C?=
 =?us-ascii?Q?kLPyfvbbA6SUzCdSiVDq+uGUyAHnWeP9hNbaLo1V+7FTkO69bV9tcyOIYIiw?=
 =?us-ascii?Q?akE67esCn3aPnFWkHvqfEaqCUNyrttFYyq781IvURXaC8aznTV17LnphKNc+?=
 =?us-ascii?Q?PR/5oGtSgu9ibQtNnen8yydk5NENyLTKvgd/bQsFUgj2IovhiSh56vRm4AbJ?=
 =?us-ascii?Q?nb4ToExyLaiHEKOjMQxv5Kam8t8DQoovPGYZ4piNM85HGftcG44RUKf83NBE?=
 =?us-ascii?Q?sFZ+gIb3uDoy6Fqwj/8GrBLr/fj0TQ1EhGySFHPtii2ant2f/fGso0tYluoF?=
 =?us-ascii?Q?7bliGS01Ou1DKTwZYjiUB924cvOMrnZDzXSOqR162XxQhQmuYXVTwzhtIv1Y?=
 =?us-ascii?Q?v0Nn6YgIudw+X6F2ssHxKnsYH2KxyPhuqD218MhA0VoJBdQbsdOBshVBOIbq?=
 =?us-ascii?Q?1jjmVhq808tBatLG/Ip9uVxBrxIlXUcih9K2gm8D++jjznFMNuvGnV0MQrw5?=
 =?us-ascii?Q?R5sQ5vClBHxzfIFpoJX2S5ii11G104oUr19uXnOM9LraQcKA/bqp8D7KF+no?=
 =?us-ascii?Q?knJLrox5KsVrtw/1BS1d0bNd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eb134f-a7db-45bd-4241-08d9790abe05
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4587.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 12:08:49.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvwBsLSjssEpRTzD5pqIxL3Yk/LRvwMc+xpcV5xd2RKT1vwqPQVddTEBdFa/W/z6i+Ck5LhrHs/gHLbdDi/oMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4620
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=664 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160078
X-Proofpoint-GUID: O0sxvEnY1lI11Mgpokx6Pe90_RIzbHt4
X-Proofpoint-ORIG-GUID: O0sxvEnY1lI11Mgpokx6Pe90_RIzbHt4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16 Sep 2021 at 07:09, Darrick J. Wong wrote:
> Hi folks!
>
> The Linux Plumbers conference is next week!  The filesystems mini
> conference is next Tuesday, 21 September, starting at 14:00 UTC:
>

<snip>

>
> To all the XFS developers: it has been a very long time since I've seen
> all your faces!  I would love to have a developer BOF of some kind to
> see you all again, and to introduce Catherine Hoang (our newest
> addition) to the group.
>
> If nobody else shows up to the roadmap we could do it there, but I'd
> like to have /some/ kind of venue for everyone who don't find the
> timeslots convenient (i.e. Dave and Chandan).  This doesn't have to take
> a long time -- even a 15 minute meet and greet to help everyone
> (re)associate names with faces would go a long way towards feeling
> normal(ish) again. ;)

14:00 UTC maps to 19:30 for me. I am fine with this time slot.

-- 
chandan
