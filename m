Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901705204BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiEISwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 14:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbiEISwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 14:52:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0F2044DC;
        Mon,  9 May 2022 11:48:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249HZIJa010429;
        Mon, 9 May 2022 18:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=j9a4qM82eMwwaOXaExlHRpBZUAVdM3AraO62sW97V/E=;
 b=x+3CPKkI3p7BvjMCuXulc2g9rYDAkZzNnMyrg17WuHp2rDj2CejXzj0MdSGsjcrKeStN
 COR9sM5uZ88kt0apTvZkooB4K4TVaYLJbp+7hqQqOXrKcUEJVCvYXuvouvAc69WWnj3o
 PRTeiuBxu/VeLU2OG/CVXFXGCytERlwdiDvCM5rPfBNG0E8PSCKfSoy4/+HxQHwN/cBH
 zYZWh6zrYznfydl66xYvTRBMNipZ9KdUUiwLtndgk2vqIGj4nCvM2Fezdq237q4NRNuc
 XpbNJiOJ6frYfhPOLkTfTqqacZD+Jig8HTOW4z6tO3iTHtlgAueAVzJ+ezZTpRx7GlH6 TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c4gf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 18:48:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249IZa3G015259;
        Mon, 9 May 2022 18:48:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf78ffhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 18:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgZG/L+mNydkF15zh+1j3pSxzsQthU6ZZEzL6Ogb+oGkchbRHY/cJgwVFUccPHAbDsK3Z++f7tD/k5i+lxhccTC7QltvgMS+hjXh+s8FAo5ACJNjW8lRXTnb3eUb0Y8XRz+/lOYzadWPQIDIPdtuYb2IV/r+q+4SBj3Kk4BmoaqWoCgPucTQN2ENM6gk1dcTtpIlvwLSAYpO/z7Z0dJ2oCxgAzsrvk7DgISPBVs5+42ok243AlZLz02tbgosRzh7oOgKyt+zsGH4pSdgfxLxs24G1RfHS5DcFhxiV4kpOINLchzt0ntA1TEQA0uuTVUdhcKdIDfdk6XhKSAH7VJYYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9a4qM82eMwwaOXaExlHRpBZUAVdM3AraO62sW97V/E=;
 b=IH5qWCyyrcdVYQu0eZy3FpP8iJHERKo6onUJrIj7PHHdXFp2hzdcvbupLyJjge008VC83PwTmngBMHVQncqBfhwwbJGa3yY+YTRYKSz5sj12Gijgtx9RxJGN1/XMqpp9e+o2f864g4ogBdWdLq4JvO1YYkNWJj2icyuPmSfMkcjUyVma1DlC25DErKTyZtjYTp76vWrIefzzpJzzC60SyoOZ+T2ETgKQSVrj+qQZnnWYsGc0nfz71Xrf2KJobcsHVD+eekV4Tfz69Bn8twKICcuAX2xOurtxzKJHqSZdhp5nJghk4IUSewNy2XkAjYaz6fCvWKK4Uq/3/k5EGpDe4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9a4qM82eMwwaOXaExlHRpBZUAVdM3AraO62sW97V/E=;
 b=YMWBevPROMwg1anHS0MDY75ywCsZB7sE2kHunPBo/tdrVgMSsT3mD/Hoy/6B+e0WQG740Sup2h2dADLNR+KUZlhZlik34IPO20i8hZf+npEfPCF7UhPSblr7N/BoFUy9DneBrOQk1ZFR9gnE8Jtlx7hxCP4smg2xYHui6WgEt6Y=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DS7PR10MB5904.namprd10.prod.outlook.com (2603:10b6:8:84::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Mon, 9 May 2022 18:48:29 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::94d7:fd30:ad97:bc38]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::94d7:fd30:ad97:bc38%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 18:48:29 +0000
Message-ID: <d53044ad-1801-b49f-b05b-c197f0057df0@oracle.com>
Date:   Mon, 9 May 2022 11:48:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: procfs: mnt namespace behaviour with block devices (resend)
Content-Language: en-US
To:     Craig Small <csmall@dropbear.xyz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <Ynjq7yN+r6sibyUd@dropbear.xyz>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
In-Reply-To: <Ynjq7yN+r6sibyUd@dropbear.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:5:bc::41) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c6011e-361d-49e7-a1c0-08da31ec821d
X-MS-TrafficTypeDiagnostic: DS7PR10MB5904:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5904284CB65CEBF2352C5CABDBC69@DS7PR10MB5904.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPSL5asK1XZqI3fnWEE9WD9p6kejIlr/sKIJ8KJvecONzT2K7MRCYEhyJZaufsfpb7w2+z7N6haIKGIhEH47/WU7zgzwMvE5ygJyi3YViI55hgV1BFYTsmsZRFyJPk/EDAMQGlTLG6voLJlLQC1nE7aiBmpqo8OpYAxsCaYXz/U32zh7RkEaLy7cAXO3+OUKEzTAkngjA7I9M2qEOTqk9zxWenT2vH/Dx8ISvls2SN2t0sFfDLg1uzjIHkzFA89fP1THdPB2XO4mqWhkWQeF56DSCZRHbFOCTfO8IXEPo2i04qjV5KvCaMf6miKBthlOGl6+iKGFo7oU/6NQG1JjnwPwM8YR+njo2D+30auuOkoEmXVLyKn81bg5IcV+OzQ12GKofP2iFxCEUzZ6yNDov5DLgyS2zZNJIYv0zK6/b+1hl84WvvfOiYRFVu61W5jSBfx5fyw5jeSvVZo5pSf1g4kWzAdu2eDA7w8FszPD7JJViZlHAZsfAMqJIltFf1CkUUxcM4PDq71i0Ku85BWBfzdntb7+0t/mmiLRz5HFRaU0YaIBKtOXW5AvuFUt+fbQVvQ8IDbe/pun4XmRlliRFK9T1/MW/uZmUGdjE3vTwVm+5Ql+WvQXv1zY1ciHu+KYNLz1RY09m2eZopU6lVABIIYM2iB67Y+UIPuUpnmudpoff/HzhFlvbXBIB2RdVTlS58nLN/pvMtbTgxUZ1nLKfMGu6O46khksdumqI1j3wZtAy6Z8C5PbsElMQI/DU1AFiYEvGqDZan0FN2WgsahgRjL69j/wutD36ODVtiD+Tl85F+Tns6lPHyxYXON5wKUo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(86362001)(6506007)(2616005)(53546011)(36756003)(38100700002)(66476007)(66556008)(316002)(31686004)(66946007)(8676002)(4001150100001)(2906002)(83380400001)(508600001)(6486002)(966005)(31696002)(5660300002)(6512007)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXBmamhMU283K3FEZk9kamZIUGdkNU9CdDNTN3A5aTRxbzRWZ0IzMVNyS1l6?=
 =?utf-8?B?NHQrRjJkZTE2TGZtTnJSOGhqUnZEYTA0RHRsOEtWeGloNU53NFNaVlNRZW93?=
 =?utf-8?B?Tmo0TkQ5TzI5SGNzaHJtdlg2akhtWnNFNlA0NDNZTHBxOXFRc1NsNHNXaGI2?=
 =?utf-8?B?SFFybmttKzB2T2NPNXlsV1pQOFpLbWJwRDRjUlVHZndkY3c1QjdHVWprUVZh?=
 =?utf-8?B?ZnNmeUptK2NlQWlmeWJtSm5IS3VJbW5ISkJFSFRuUElyL0p2aXBUbXUwOVkr?=
 =?utf-8?B?TDQvV1Ewc1FiTUR1SDFxUnpXOWY5MkJ0OS9QT0F4SkswSEZHQ3lQTktzRVcr?=
 =?utf-8?B?YkFESEpnMmQ2cWRGS1c3VHJ2MGI3SUdGZG91MXIwVTdhcjJrNnNqdkNidFkz?=
 =?utf-8?B?d20vdWgyc3UvQkRyS1VEcmk1T3BObGh6V1l3cmhxVnRkQW1lT3lzZXZORHlk?=
 =?utf-8?B?ZUkyUmpRLzVJMUFhL1prOGdudWJoVDNiUHRHVlluUWRYbnBNZnhRMitxWWVM?=
 =?utf-8?B?NWFXL2lLK001S0ErTUU2VDBvNHdOWUFhY1lpUXJqVkc1M3hvdVN4cXRSNmlv?=
 =?utf-8?B?dC9RajdFV1hlUTdUNWJza3YwS0xwSFZhSXR2REJzdWo0d0VDVnhhVXQ0UmlP?=
 =?utf-8?B?SCtkL0RrSUxsZVBUaVluYlM0clVqSWRJMWJTbFdqeW5KbzNGYldKWHB0cXRX?=
 =?utf-8?B?MUZWcEZKNmNrbElyREd5eXIvZ1FZT0N4ellWY0NEU3lvU2VTRk1EaGEzN09G?=
 =?utf-8?B?NVlLOTNnQVhhRUtNby9BZTRVZjJadVF2Z2o4bVEzZ0xRWDNIOWFFS1p6ZXJE?=
 =?utf-8?B?OUQ4ODA4MzhFanZJZDNGR3VDbEEzV2tQSE5hSHZFc2tKNVkvelhwMG1PR1hy?=
 =?utf-8?B?SXA1TFBxdFRZb1ErejZ0cm40eXRmRytIMy9hVzZ4YlN3cnRaTU01aXBUM3Rt?=
 =?utf-8?B?WEtIVnV5cXF2U2wvNjRTbmgrRDRRekVNRzE4Tys5WnFIei9YM3pFUlhaa1F4?=
 =?utf-8?B?U2J5WUZPajRjcTFjcWxJL21mdDdWVGk3Zy9lS1MwUzVwSVVwTjVqRklEOFVC?=
 =?utf-8?B?amRUMk9ZREVUUDhiRk91VEpKVDJmSHVoOSs2TERtWVRKdEY2THNrelg2U2x0?=
 =?utf-8?B?SU1XSktHOFI5YVBYY1dQQ0JQQ015SU5sWXZ0Q0QyUjYxYjFrSFNZVDd3Wnlk?=
 =?utf-8?B?aUZtajdHYVJvaG5kTjRJQ2hCMzdHRmt1M01UVkgyWk51eXNuUzdreXd3M2lz?=
 =?utf-8?B?Y3Y1MFYrdVdCU0FNTUk4U09DbFVPUWZZM1JPNmxqVTlGQkM0dGZXdHhuUHdM?=
 =?utf-8?B?M3ZhYzQyUTQyZHZRZ21qRmFhQjEvaHM0S0g4Sm52VVhKV2RRdlo5Q1NkaE5u?=
 =?utf-8?B?aS9naDVLUFJUVjh0dDJNY05MTGMzRTV0N0JFZSsvSlk3bVV1SXRMSUtRQ2tl?=
 =?utf-8?B?SGJTdFRJeDVWWnBvNGEwRmM1VVFwa3VNOUpsbDZKS0ZWUzduZmhadzlzOFNM?=
 =?utf-8?B?YkQrMkVJeEFLZGZXRWNTL3Z1ZVpwbHRkWmhzSkIzUnZ2OEFWZ1owYkFqNW5W?=
 =?utf-8?B?NnhpaWFvb0szZnRIY1JwTkxtSDRZZXRlSVVRUVhPeUxPOWU3QUVvZ0R6dVZn?=
 =?utf-8?B?N0ZwVUl6VUphM01rNlE5d0Y5dkF0YkUwbEE2WkNvR01xSzlpaFQ0dUhCaVdw?=
 =?utf-8?B?NVB6NDNuUDBpR2ZGdnBuYk9rSk9tSG9QMStucFlDTm13VWpjMi9PZGZsbGtj?=
 =?utf-8?B?NUxFRU1DdXJ3R3d5aTliRkNvbVpnazdDc0t4cGU0cnFTZDFZZ2EwVHBGd1Bk?=
 =?utf-8?B?bzBOUTZFeHU3eGZSb2EvUW1USlZHOFVBWVNPOTJQUVpTbGJOTHNTUWJoVkEy?=
 =?utf-8?B?TzEybnZMRmRMbU5jRk9ULytyNGwwdk1KaG04Vk9zV1JWc2VJUm9kMU9VL0xv?=
 =?utf-8?B?R0hOWXFidmxVU1NES3pwR2dsekMyTWtaSzNFVDd2NGNLQnlJVmJvbGV6N1d2?=
 =?utf-8?B?QXcwL1ZaUEFTc1pRSkZnVXA4N1d2Zko5N2Nwa25EenNoTkJrWkFHY0YwVW53?=
 =?utf-8?B?Vm9xRlJNbnE2d0FTYVVZdENnTTFnVlBNK080cCt3MmtQNmdDMmhCODZXQzkx?=
 =?utf-8?B?bUJRSUlINW5jVDZOcjg2UFZmMTRJYWJ2TXE1ZEltQnFoZHJMdVJ1TnlDV085?=
 =?utf-8?B?bVlYMDhnNTdudEF3M3VrMllDN0JIK3BnZEg2ckFqWDI2SVBpQzJoYXJQQzg3?=
 =?utf-8?B?ODdCZ1lCcXpaRUs0RHBpRkZGOHdIb1FUazhKUEF4ZTlENUdra0VLKzVMWnZI?=
 =?utf-8?B?UUp3Wmt6SjlyMnEvd3FKOVVkV25aZGd6K0tacU5kYjlrbkQrYkFNN1lsTEdh?=
 =?utf-8?Q?3H4b8rYFAFQlUDq0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c6011e-361d-49e7-a1c0-08da31ec821d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 18:48:29.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVIEG78Jh9oosD/wOHJp4D5En/iZeD9k8MKAZ7AYctpgxQfObZ9EbrAEAcJlqfhQCpb8NwKD2vCbbmLP+GL1dtRZyi8FXLTrnRFf4bdw4kY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5904
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_05:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090098
X-Proofpoint-ORIG-GUID: RzR7i6KO_a01YwSr2tl2Ecw1gp5CJqSf
X-Proofpoint-GUID: RzR7i6KO_a01YwSr2tl2Ecw1gp5CJqSf
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Craig,

On 5/9/22 03:20, Craig Small wrote:
> (resending as plain text as the first got bounced)
> 
> Hi,
>   I'm the maintainer of the psmisc package that provides system tools
> for things like fuser and killall. I am trying to establish if
> something I have found with the proc filesystem is as intended
> (knowing why would be nice) or if it's a strange corner-case bug.
> 
> Apologies to the non-procfs maintainers but these two lists are what
> MAINTAINER said to go to. If you could CC me on replies that would be
> great.
> 
> The proc file descriptor for a block device mounted in a different
> namespace will show the device id of that different namespace and not
> the device id of the process stat()ing the file.
> 
> The issue came up in fuser not finding certain processes that were
> directly accessing a block device, see
> https://gitlab.com/psmisc/psmisc/-/issues/39 Programs such as lsof are
> caught by this too.
> 
> My question is: When I am in the bash mount namespace (4026531840 below)
> then shouldn't all the device IDs be from that namespace? In other
> words, the device id of the dereferenced symlink and what it points to
> are the same (device id 5) and not symlink has 44 and /dev/dm-8 has 5.
I'm no expert here, but I think this is working as intended.
It's definitely confusing!

Consider a process in a separate mount namespace from the init
namespace, e.g. a container. Say I were to open python in that container
and then do `os.open("/etc/passwd")`. If I were to then look at that
process's file descriptors (from the host's perspective), I'd see the
following (pid 220854 is the python process in the container):

$ ls -lah /proc/220854/fd/
total 0
dr-x------ 2 stepbren stepbren  0 May  9 11:06 .
dr-xr-xr-x 9 stepbren stepbren  0 May  9 11:06 ..
lrwx------ 1 stepbren stepbren 64 May  9 11:06 0 -> /dev/pts/0
lrwx------ 1 stepbren stepbren 64 May  9 11:06 1 -> /dev/pts/0
lrwx------ 1 stepbren stepbren 64 May  9 11:06 2 -> /dev/pts/0
lr-x------ 1 stepbren stepbren 64 May  9 11:06 3 -> /etc/passwd

$ cat /proc/220854/fd/3
<contents of container /etc/passwd>

$ cat /etc/passwd
<contents of host /etc/passwd>

$ stat -L /proc/220854/fd/3
  File: /proc/220854/fd/3
  Size: 900             Blocks: 8          IO Block: 4096   regular file
Device: 4eh/78d Inode: 5508982     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-10-27 10:24:28.000000000 -0700
Modify: 2020-10-27 10:24:28.000000000 -0700
Change: 2020-10-27 10:24:30.255374190 -0700
 Birth: 2020-10-27 10:24:30.255374190 -0700

$ stat /etc/passwd
  File: /etc/passwd
  Size: 3216            Blocks: 8          IO Block: 4096   regular file
Device: fd01h/64769d    Inode: 24917416    Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-05-08 15:06:18.837117765 -0700
Modify: 2021-11-30 09:08:45.163873193 -0800
Change: 2021-11-30 09:08:45.167873237 -0800
 Birth: 2021-11-30 09:08:45.163873193 -0800

## INSIDE CONTAINER'S MOUNT NAMESPACE
$ stat /etc/passwd
  File: /etc/passwd
  Size: 900             Blocks: 8          IO Block: 4096   regular file
Device: 4eh/78d Inode: 5508982     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2020-10-27 17:24:28.000000000 +0000
Modify: 2020-10-27 17:24:28.000000000 +0000
Change: 2020-10-27 17:24:30.255374190 +0000
 Birth: -

As you can see, it's the same behavior: the path /etc/passwd resolves to
a different inode in the init mount namespace compared to the
container's mount namespace. The secret sauce of the /proc/$pid/fd/$fd
files is that they don't behave like a normal symlink: instead of using
the file path to lookup the target inode, they directly lookup the file
and inode of the target process's table.

When you do a readlink(), the kernel has to create a path string, and it
has to do it from the perspective of the mount namespace of $pid, not
your monitoring command. The reason is that there may not even be a
corresponding path outside the mount namespace of $pid. Imagine I
created and opened "/etc/foobar" inside the container: that file may not
exist outside the container, so how could readlink() make a path
specific to your mount namespace?

Hopefully this helps, but maybe I'm off base and missing the thrust of
your question, let me know either way.

Stephen

> 
> I get that if I could look at the device IDs in qemu or use nsenter to
> switch to its namespace, then the device should be 44 for the symlink
> and device (which it is and seems correct to me).
> 
> How to replicate
> =============
> # uname -a
> Linux elmo 5.16.0-5-amd64 #1 SMP PREEMPT Debian 5.16.14-1 (2022-03-15)
> x86_64 GNU/Linux
> 
> The easiest way to replicate this is to make a qemu virtual machine and
> have it mount a block device. I suspect there are other ways, but I
> don't have many things that mount a device and switch namespaces. The
> qemu process (here it is 136775) will have a different mount namespace.
> 
> # ps -o pid,mntns,comm $$ 136775
>     PID      MNTNS COMMAND
>  136775 4026532762 qemu-system-x86
>  142359 4026531840 bash
> 
> File descriptor 23 is what qemu is using to mount the block device
> # ls -l /proc/136775/fd/23
> lrwx------ 1 libvirt-qemu libvirt-qemu 64 Apr 12 16:34
> /proc/136775/fd/23 -> /dev/dm-8
> 
> However, the dereferenced symlink and where the symlink points to show
> different data.
> 
> # stat -L /proc/136775/fd/23
>   File: /proc/136775/fd/23
>   Size: 0         Blocks: 0          IO Block: 4096   block special file
> Device: 2ch/44d Inode: 9           Links: 1     Device type: fd,8
> Access: (0660/brw-rw----)  Uid: (64055/libvirt-qemu)   Gid: (64055/libvirt-qemu)
> Access: 2022-04-12 16:34:25.687147886 +1000
> Modify: 2022-04-12 16:34:25.519151533 +1000
> Change: 2022-04-12 16:34:25.595149882 +1000
>  Birth: -
> 
> # stat /dev/dm-8
>   File: /dev/dm-8
>   Size: 0         Blocks: 0          IO Block: 4096   block special file
> Device: 5h/5d Inode: 348         Links: 1     Device type: fd,8
> Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2022-04-12 16:15:12.684434884 +1000
> Modify: 2022-04-12 16:15:12.684434884 +1000
> Change: 2022-04-12 16:15:12.684434884 +1000
>  Birth: -
> 
> If we change to the qemu process' mount namespace then we do see that
> /dev/dm-8 has the same device/inode as the symlink.
> 
> # nsenter -m -t 136775 stat /dev/dm-8
>   File: /dev/dm-8
>   Size: 0         Blocks: 0          IO Block: 4096   block special file
> Device: 2ch/44d Inode: 9           Links: 1     Device type: fd,8
> Access: (0660/brw-rw----)  Uid: (64055/libvirt-qemu)   Gid: (64055/libvirt-qemu)
> Access: 2022-04-12 16:34:25.687147886 +1000
> Modify: 2022-04-12 16:34:25.519151533 +1000
> Change: 2022-04-12 16:34:25.595149882 +1000
>  Birth: -
> 
> Thanks for your time.
> 
>  - Craig

