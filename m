Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88EB70866D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 19:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjERRLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 13:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjERRLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 13:11:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A529F;
        Thu, 18 May 2023 10:11:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IF9Vuc003895;
        Thu, 18 May 2023 17:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zNZcg1vnaYnL4TYfnhVFW57H1bU0JU3//BVVgJb9T1s=;
 b=jxRKbXlDje+JzYMgeygDoJZakrIcBlX4c4xIowobc3qRaDj+fEbZjQvV0JYOdIX46+R2
 A8n8+sMqlmnU0eH2Rv1CojT73HizZOYr9ZRrhvDi2jXh990owmNyi/9L6xGs3FTicIPQ
 hx6B2Fb4iSe6rrzoyM/OyXBBiIx7ez4F19mpJq+MrDO5gKRHGuHgZNBNSylr6Y90WT0N
 0PbIEdJPqkVmRzn6+3uebdOKfv79IpQ34A+E2sGiigc+ANEdEDUH5ikGSnay3w9dZhKY
 DOgoc7XPmQHXb4oKfgP5MFIi1YIvtCohPh7nzb6BofSBZAKY1gpdegJOhyZ481CBHSME LQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33v0f7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 17:11:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34IGrgxc039993;
        Thu, 18 May 2023 17:11:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj106sxfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 17:11:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBM0uw38B1ZA0c8RZx2Gcdq700h4lNxrXZagbHvmk7+afEsow3Tav3oHU/cldEpNLxMIJwrWoxB9kePB9Ww7XeXcsIbP73n2L6vPworWg2bk1Pivuqk4tzQzO63+uAWyB8T+7TCGV7qKX2bArpp75jgqq1bbpg76JXSeKqkLXE+kH0W2khORyM3V3SL/EDHRaMHuWbscteNjMSEKpESRinxiKgRQzM8yvL06EhVsQnJVXhN1NNMQ4ZaIAa7uUOlvIyxjVfB1XIqd1+GLB/t07tLinXUj5xdRt8bqrRM9rXmC++cjkVdoebOd1otm1bgUfG2SE2cgOmWc19EpV6/0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNZcg1vnaYnL4TYfnhVFW57H1bU0JU3//BVVgJb9T1s=;
 b=hcGNVrjuQrp7l71xqLxBrKbVTY39llQmjorDAgu9pwXbqVue4a0LywQF2ECFqCleX1o53mtYDGkEFG5Y9lHkXO9urp7LBfLJFhIrco8aO4jWHOe6iq+tQebPuJLvl1xPxS+66zQnzf4v1cFRQ8W/fmax9m/5Cv2p2ZFZ05rSBCO6ttEQzxiGZ/6dYDrI/a429kIUtY6KeLZLyrk5F81NQHajhT2X6bh8LEAyYAX8GLPJRDmbIqntT4KXV8ojpxYC2kLFGq120/PXGf7vX9fNmo7xA5r0VQwC7wURsxdTEiagf01HY3JX3YtkaY6PVZPVoppo/ACybAu42q4Itdr56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNZcg1vnaYnL4TYfnhVFW57H1bU0JU3//BVVgJb9T1s=;
 b=hjBWxaBJvckqbcJWxHFAJT1H7SSCRY5uiikdjqshsYwBGly8LDQ4xTw92mP3fVEo9rdMglnxyeGqz/fkQ32Ag8HQmilPgJsMI9nASXrhAtVKJjEr+/PIoTihyY1Bl+xbXV9Hl16968UOoEvamD9ESJ9Ci0fC7+LN13wlabGmbr8=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 17:11:23 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 17:11:23 +0000
Message-ID: <21ad5e62-b3d1-2f74-d3fb-819f4e6a2325@oracle.com>
Date:   Thu, 18 May 2023 10:11:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] NFSD: enable support for write delegation
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
 <1684366690-28029-3-git-send-email-dai.ngo@oracle.com>
 <1B8D8A68-6C66-4139-B250-B3B18043E950@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <1B8D8A68-6C66-4139-B250-B3B18043E950@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:254::9) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MW6PR10MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dde952-5874-4c4c-78de-08db57c2e814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tb5KRXxcnMOUZBX/Wvq4H7diIApOJCgGTUm3IxYEJE1z8tarBG9l+Xr//6/46op1GFpuwbYUWyIAhh9L+30ixm7sCxoSzY4GTFSWpibESlVXU5vT+qJltBmaCEnWb4pKhw2xyZWDadGviV/Qg9XxDUIfEIVYR6xGbjedDP3uu3i86YaYNUXE/HRtgItv7k43IHbityoHY6VQpdP8yad1lexAlPpgQTmI49JbPwqpsSHznFYaVnuvfJZkf8s8ge64aF7oZvwOozABF1I4SjAlXm9/VMpGHSd1BLDfVylblJhXncgBdAGvBqZfRdMS36b2oJq43jfrn8kJ7tHKJTq17P3xOZf1F2M0TitqB+o/DhX48J9cjLyDkzHyuVDFPpBkPOANf/0GdBhOMRJnpBtAUNu6l5x6aFS9W191yPuYurLpl1cxMx0IWury3NFrSCsPZJn7UotU4kdUvhIlIRtx+6XOWlZW/I6235lflWw/KchBVxjJTnwXBJQVKpAlcSWsnNVrYEGvJ6hk4S66qyC13ZVicYte8FvSzJtQVD6Wp4/7IGDopjA4b7p3Xmu2nbvwYA28cTradGhsw38BucHwUDgcmtruKEFMyP8IJVneI5VyFlWEDS25TuwYG176gh2o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(83380400001)(66899021)(26005)(186003)(6506007)(6512007)(53546011)(9686003)(36756003)(6486002)(2616005)(4326008)(316002)(2906002)(66476007)(66556008)(66946007)(38100700002)(478600001)(31696002)(8676002)(6862004)(8936002)(31686004)(86362001)(5660300002)(41300700001)(54906003)(37006003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEJHdGNlK1B4dys4SGtWY0p1TUhRc3BYcXE1c1ptaXhPYi9tc2ZUUHltWTkw?=
 =?utf-8?B?T0ZMc3dEMTJXQW1DWXpxUHNDSk5VRSs2b3lObUJac09CSllXb2NyUVl1Rmts?=
 =?utf-8?B?dGRYUWVFMW9aUUxIaEdyaWxteFV2a2cxQUFHOGZvZDEzaDIrNkN2YndtVjN0?=
 =?utf-8?B?bXlTWkY2bisyYkpKSjdFQlYxb0VtN0N1UzY2Z1VST0MrYzNOS0FzdU9MbHdY?=
 =?utf-8?B?NjhMRDIvTW9sbDcra3BUeHc3V3h5THZSZU1qTGNnVURJUzM3c3I5eWpJTlps?=
 =?utf-8?B?bHhCcDE5U2hEcjUzUy9ZYmRPWmVmZjY1MjRKV2JpM3ZXWWJ3NlZsOTFpZTZH?=
 =?utf-8?B?bFcrYXlPbVNJVzlVdDdqOWNCTGJmSEpCVStRdXVMRXlrYlhIU1pRRytSVG1J?=
 =?utf-8?B?RXltLzA2V2h4c0QxY2J3aDBGRXBzQW9EU2pBN1ltTkQ5V0ZhVDkwSWxscVMx?=
 =?utf-8?B?OWxWbVdqS0pyQkd0ZW80N1hkZDhmMDJjQkNYQTNKNTJIVW5nY1ExMXQ1Mmc4?=
 =?utf-8?B?UTkwY2dPbjFWQkQ5bHJScERtUkhyWTZYck9NM1piWlUwSTBHZndzblhEQStk?=
 =?utf-8?B?OEFFdG5vNVFpZHlvNFBVZjB2eVkweHFCV1RpVTdwL2RHcUhNWHM0NE11d01h?=
 =?utf-8?B?dHB6YjB4dmlVdjRRdWRRRGs1U2IycWxDdHhDSUVGc1FJcWNnUXZvWVZndHZC?=
 =?utf-8?B?YjkyNHdXLzJSaktHakFkWlhKelJMc0FiTjNINXBIMVJITEdLUUUxY0NOV3dt?=
 =?utf-8?B?UTArUktrdzFxQnREYXZpRUxGTnlYbGlMb1FML1Q4cTBGVEltc1hDRmE0Zm1K?=
 =?utf-8?B?c2RWR282NlhZUFJ0ZlBaazJsQmtYZ04xZ2sxOThlRlFJL2hUQ01WdUJOeDZs?=
 =?utf-8?B?Nkc2UUd5ditQczlTd25XYWRvSndpK3U3bmtuaXd5VjVOTUV5YlVDQkVWd3JS?=
 =?utf-8?B?UkZwbm9aZlI3dWorWjhZYWhLUDR5OWNRV1Fud1FlZXQzMnJvTVRBQStDejVu?=
 =?utf-8?B?eU9WWUdBWERRK2diM1VEWDIrK0VZVG5IaFdEbUYrL09LdFQvdFhMSDJkWmUy?=
 =?utf-8?B?VTQ0cXdyd0hIQUx6cjhOV2w5Y1RpSkxuZWU1Uk1XaCtWajZIaWlsZ3haZHhE?=
 =?utf-8?B?RVJZTklsbjRsR1RwRXlMTEw0aTlhRmhLZmplTFAweWJIMnE2UUJ3WjAwaDAw?=
 =?utf-8?B?L3VOTy9aVzVmdjFvZk1IdXZ6L29UNVFTQXU1VG9DK1VhczV4Y2tCY0hucnAv?=
 =?utf-8?B?UzI4QWRiS3hWMU00d2hyTGFLaWU5Z1BrYit1Sm1Wb0x1aVJnWWpyODRRMytL?=
 =?utf-8?B?SnVyY3lYTWZIT1V6SkdNMU1WQldId2ZmK2VPT3U1TjJ6NEpqUXNSOUlUaTZn?=
 =?utf-8?B?YXpWWFBEamI3b1VDK09ZTG9VL3Z3RG1yWDBoLzZMVHFiUGxENGkzZG1RTlU3?=
 =?utf-8?B?bkl0S0ZTWVRyZlRnZE94THprUU9BTU9sTVZmZUlUcXl5SzlyOHRETnJYYW5w?=
 =?utf-8?B?WnlrU01sbFF0T0xQSk10WERvZENRRG1MREMzb255UGhEQWJaMHl1UjlkL2c1?=
 =?utf-8?B?NDllTFZzaEMyWnZQTVlhWk9qM1FoeW5oVUNUU0Zua1EzUUNTK2t1cnJhN2FH?=
 =?utf-8?B?MnRTR1crUGp2L0c3ZHR1SXVaa2EvZnFFRTJyaHFrQklxV056NGV3d0pHNWdF?=
 =?utf-8?B?ZjhvWFo2YWtEaTk5T3FpWUNQU0pTaVhVWisvVDNJK2FnTWVwbkFUTzFHcmlo?=
 =?utf-8?B?MW55VE9IVTVDY1dTbWU4eXpMbTNIV3h4KzkyOGNDS2J1SnYwVGU1M2lBak84?=
 =?utf-8?B?UWMzckNKYkdJQzd2V29WNEx4YzBoTGxQT1lTS0hNbzlETGY4SXczNERzU2VT?=
 =?utf-8?B?Z250NXltdTFOVkowbTVCMWQyc2hGMWdTWUlFTUgxMXdPTnk3NWlSL0JCT3Ev?=
 =?utf-8?B?Z1BWQjE5TVE4YzdNdmdTaytzWWsyaGdaNmZQenJnREozM2JMM1FtSmRGaExm?=
 =?utf-8?B?bTYxSjhHVHdhdVVJdVd2cnlBTm5iam13SjlkVW04K0h0aXBqUEdobEkvUkw1?=
 =?utf-8?B?SXc3YWJKKzZ5amYwTGtyYWhoR0dCcGw0RXlVS3BoN3Y4ZnloNFU2UmUwSjgx?=
 =?utf-8?Q?a+SMzaDuxcieJ+1/ziTmNVv3B?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TDjB+aXyTlgDV156lnstzfgD8QihDbWMVGEkoDWTqvhBKr/f6Cl5+GEXQXa72DXHgZ8gzokyMmH0G8doy3+WhvF92hXR6BaD/+WE5uqGkmRVWoxxt+dufmOeOtdrtWPtrBoxQJMBDm4Gz+YSiJl7Vp3OahDZzdN/W7rFPGHwQLMnvSdgdvRvfFZ5i++bFoz7xjn0sJ5SXoBl4wFjfJlnQERZEZTOs1UJBLF0R/coKyT6PbmHa1sF4LOYGoi0oZnvtHGjFShckRpipBq1u0ngEpOSiQLXZRa706OeX0xoBr0efrCgt2wyfmGxxCePcJRu1B6MScxeMU16abqXbvVUpIMzGsawhZuWvtbGWRMy0ck/m5LyGcY3krahXuAya4L+5pzd8CWdrymi+o2MxizW2lUOc1bmpvv+1Finv1UNhnpl6jHaWAAethzRF25HsV3vkAQa9eWyqHFPM02jMn6cBU+t+k8hioYAW+upLW6X+LdxUFFAPrEoWoOcu7mxSma8e8mRacXj5cVLOZtAN2pZDtqdO5a3X4UJcPzX7cH0IsKT8uhbI7cVGd8TogUdkEBQH9Rx+J2fpeDeRB086Yk+9MqncJ+mH3q09A4+W4UOkqDL8WVx4ZNmwo6YFXwNdJLWAd2u0LoKZbKO9aLUoFoJ5bK/jGh7AzGcduwBoGbMCu1nm+/xbt8JBGnXlNZeF3cQQsvAPYsw/IuibvacuWE6Qome+3fwu9qgAGOLmXlesUvePeCCKpQibWQr7Hx9NZiVYEoyNPNeZsP12iGUBwdKWz4KoXW20StHKFUVn/mQrwo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dde952-5874-4c4c-78de-08db57c2e814
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 17:11:23.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KbAiZU6AD6YJR6srIYwG0xA3ueH5H3s9ZqrJ+eN2LyYq+YetPIsHO3lsL80EJeAVSu6kPzpVMqKB3L13+nBoHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305180139
X-Proofpoint-GUID: sizOg6YX9XPpkuf2gCIOjQd_y5wZIrsX
X-Proofpoint-ORIG-GUID: sizOg6YX9XPpkuf2gCIOjQd_y5wZIrsX
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/18/23 6:23 AM, Chuck Lever III wrote:
>
>> On May 17, 2023, at 7:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> This patch grants write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
>> if there is no conflict with other OPENs.
>>
>> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
>> are handled the same as read delegation using notify_change,
>> try_break_deleg.
> Very clean. A couple of suggestions, one is down below, and here is
> the other:
>
> I was thinking we should add one or two counters in fs/nfsd/stats.c
> to track how often read and write delegations are offered, and
> perhaps one to count the number of DELEGRETURN operations. What do
> you think makes sense?

I'm not sure what these counters will tell us, currently we already
has a counter for number of delegations handed out. I think a counter
on how often nfsd has to recall the write delegation due to GETATTR can
be useful to know whether we should implement CB_GETATTR.

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c | 24 ++++++++++++++++--------
>> 1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 6e61fa3acaf1..09a9e16407f9 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -1144,7 +1144,7 @@ static void block_delegations(struct knfsd_fh *fh)
>>
>> static struct nfs4_delegation *
>> alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>> - struct nfs4_clnt_odstate *odstate)
>> + struct nfs4_clnt_odstate *odstate, u32 dl_type)
>> {
>> struct nfs4_delegation *dp;
>> long n;
>> @@ -1170,7 +1170,7 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
>> INIT_LIST_HEAD(&dp->dl_recall_lru);
>> dp->dl_clnt_odstate = odstate;
>> get_clnt_odstate(odstate);
>> - dp->dl_type = NFS4_OPEN_DELEGATE_READ;
>> + dp->dl_type = dl_type;
>> dp->dl_retries = 1;
>> dp->dl_recalled = false;
>> nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
>> @@ -5451,6 +5451,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> struct nfs4_delegation *dp;
>> struct nfsd_file *nf;
>> struct file_lock *fl;
>> + u32 deleg;
>>
>> /*
>> * The fi_had_conflict and nfs_get_existing_delegation checks
>> @@ -5460,7 +5461,13 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> if (fp->fi_had_conflict)
>> return ERR_PTR(-EAGAIN);
>>
>> - nf = find_readable_file(fp);
>> + if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>> + nf = find_writeable_file(fp);
>> + deleg = NFS4_OPEN_DELEGATE_WRITE;
>> + } else {
>> + nf = find_readable_file(fp);
>> + deleg = NFS4_OPEN_DELEGATE_READ;
>> + }
>> if (!nf) {
>> /*
>> * We probably could attempt another open and get a read
>> @@ -5491,11 +5498,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> return ERR_PTR(status);
>>
>> status = -ENOMEM;
>> - dp = alloc_init_deleg(clp, fp, odstate);
>> + dp = alloc_init_deleg(clp, fp, odstate, deleg);
>> if (!dp)
>> goto out_delegees;
>>
>> - fl = nfs4_alloc_init_lease(dp, NFS4_OPEN_DELEGATE_READ);
>> + fl = nfs4_alloc_init_lease(dp, deleg);
>> if (!fl)
>> goto out_clnt_odstate;
>>
>> @@ -5583,6 +5590,7 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> struct svc_fh *parent = NULL;
>> int cb_up;
>> int status = 0;
>> + u32 wdeleg = false;
>>
>> cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
>> open->op_recall = 0;
>> @@ -5590,8 +5598,6 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> case NFS4_OPEN_CLAIM_PREVIOUS:
>> if (!cb_up)
>> open->op_recall = 1;
>> - if (open->op_delegate_type != NFS4_OPEN_DELEGATE_READ)
>> - goto out_no_deleg;
>> break;
>> case NFS4_OPEN_CLAIM_NULL:
>> parent = currentfh;
>> @@ -5617,7 +5623,9 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>
>> trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
> I'd like you to add a trace_nfsd_deleg_write(), and invoke
> it here instead of trace_nfsd_deleg_read when NFSD hands out
> a write delegation.

Fix in v4.

-Dai

>
>
>> - open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
>> + wdeleg = open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
>> + open->op_delegate_type = wdeleg ?
>> + NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
>> nfs4_put_stid(&dp->dl_stid);
>> return;
>> out_no_deleg:
>> -- 
>> 2.9.5
>>
> --
> Chuck Lever
>
>
