Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F60626437
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 23:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiKKWJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 17:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbiKKWJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:09:08 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6927833C;
        Fri, 11 Nov 2022 14:08:53 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABM6coS008347;
        Fri, 11 Nov 2022 22:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ZdqCd1KZ/tNfF1Ei+BKfqiqM0ruZyBD5M1sd2q2S7Hw=;
 b=ttmpOjZwiRTu0VNCeEah2FLxClJZ7p4flW41DwtZqaKNIvNwC8v5gKvatRaRKV2jV3Ey
 B/ZDe6/nrAuRk2Gd2Dv8TuFTugyUH858++2qEhDF0J27P9Zh3G67jlpQ1WKtqdVT2tXo
 emeiquA/75E4hKhLVmLYIPTY6zGHaAxzPpJ8JLwWhJGscy6eAF6R0rs0YwNsMvY9nQZ4
 u/oWXAn3suniIfq8axLp998iL8uT8I4HrU8fL8qfXLmqJ1HXei5/VONy1rWPXoAPJDiH
 BuN5jbcjXWw90/rT0mcRJ1psuCh6sfwedF8LI0igzwh0IOp2AJS7R0Eb3RF9JxzkIdLB ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ksxkx00km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:08:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABL0Rdt021320;
        Fri, 11 Nov 2022 22:08:48 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsjfsj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 22:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COfUUjmpuHE465JWcTcNg0ULa/qKKerbAXuQ/OeJSdIPfVhpmT0rYAjCB6Gn3nctC3AVaZq6dtItPtu24F1lfXrzTugZfBcnOtdd0Kag075ehe5/SmbNgMcoP/231Vi02NIwy0pthVZ4zZ6Cp5ESzy+8tI1Dzgo4vxdccVHCHwJgfMESBjFI6Of6RWOSnT4ntm9PSMEVlNS1kCJtkeXD+YysyA5z1KpIelEfHqbEWP6k4hc57ITQiR0cUXUdK+CLkCjcoG2ZfZ6QHveXdPgjlV+lMqNAR4d7+tKFfGyGLHRpwS4gzNBgAF1gEEHlRXTehDWk9A8MsntlfgFf/9FJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdqCd1KZ/tNfF1Ei+BKfqiqM0ruZyBD5M1sd2q2S7Hw=;
 b=FdApXeVT7TZucSQJjkUpGONWIReod/xShu29ACDbYXlL8hss3TrCNERJQuhfYBt1aXBDZVZgPWe4xO4dmgzuWqYYocm6uk1BqJQextVtdzuZQcRF33pXev4Gyjgn9L03CliPMQN6xuYyIrUE3AfueUH02EdJI6ikUrAXwN0jB7wZakpSMziFPno3/aF9DCRhxbLe/46eX/HxEPl3j6VaKV0//4JrFSRcUBz9stJgcUifJ/NCHxQ5bfFJ/6rYG6TUUEHwOBHynJiwGxDeWpb+8lpizhDy39iYNQmaeH1PX5oY5Kku35zQ/vYRh562ZFFf0dTAzCDmksh+VcBOP8yn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdqCd1KZ/tNfF1Ei+BKfqiqM0ruZyBD5M1sd2q2S7Hw=;
 b=DkmEBYEPadYYNxe7yiHw5ubKp15/nYM2OMHCDUFAXG/0ifGJ9DBzwv9HwAPpvJulYmi8B9isNSxG/mDYRC+y2eOpL+ZOxBD9uzSb3n8CellSf/BAsocXt8NnD1gOkhX89vuDkD8iaMYlHPyr5ZucylVGvIDXTnAd6H7UhNMOdto=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by IA0PR10MB6914.namprd10.prod.outlook.com (2603:10b6:208:432::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 22:08:46 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::c544:e51b:19a0:35b2%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 22:08:46 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 0/5] fsnotify: fix softlockups iterating over d_subdirs
In-Reply-To: <20221111220614.991928-1-stephen.s.brennan@oracle.com>
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com>
Date:   Fri, 11 Nov 2022 14:08:45 -0800
Message-ID: <87bkpdf8k2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:5:190::41) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|IA0PR10MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: d9067642-052a-414b-326e-08dac4314df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqmMb9CmNQo4Dxz/i4Gr0Qh3wWoo/DocRHApCsDw1wJ/5W07a5qMObLuIV7CNyIYFsFefYCLh/kIit3d+OQICrVGhHPu9cy0VXLpA5bjt8DnQZ4C3i3dj8MdDNxRlUouQQsejUdV0GTsvzh1wqwfEvLMlwWQUHQgurkZj6VL0XggopGGoCBm0EGk7MP/KwoVMn+Ih++jILWOkw6gxwUPO8ILnBxbBM9QjLu7gn6I+XOlny6W+sS4gLkuZjyj6mwhVmuUjNapNXfxIMRhonwIkqyst+3RMD7kiFxWYoYDxQ3gzhzky0wZkfznROe8zgoT1aMYUhFtqkTWIbklGoTHM6TZUcvEHKPpti3B5YiEYnweOQY2TSrg2VOHQw31mSj5Ej2A87+yXHvO66E5QUAlAhWzFx4mYmEXbWs9kZ8g1VQx85jfJmu42lcqaHsMwi30hFpY2drBA/9GbKmb3AHhmAXE5Unv8sqqy6N0V0zF0ZAyeBQC/4pC5l060D6Tg6AfFRkIs8VbYFa7e2MuBwuMQ1hU6xrCviSoGXnBdNohe8Cynr5JR14bRamHtg+OqZ17LtAzwSAbEpYYQEJODinCyr4W787j957sbAkQx94KeLP2sc+eNk02sijISJTOqDwsDsLIwMFGisJcXz8WVrnf2/JVw0B9i+8UaLHG678nmUqFmEKAjleZRGa4aBKWkF/xuONHYUKhBbRO36U6F/D57w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199015)(83380400001)(26005)(2616005)(38100700002)(186003)(6512007)(6506007)(66556008)(5660300002)(2906002)(6916009)(6486002)(8936002)(41300700001)(478600001)(4326008)(54906003)(66476007)(316002)(66946007)(8676002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hePXaf73F3naFnVBBbducmwNMDpOO+lZ8EFTuslZdz04lAlExsFKcxh7SJrI?=
 =?us-ascii?Q?kv7wiEpnQHMLdXI+qmATfgE3oGFu8lsNVUIKK1e+XXIJWqD7uxu+vyRVqZdz?=
 =?us-ascii?Q?vEMozwQW/LRZjLQwDlkyzQyPF7zqm8vR0oRas73XSg9oLqtk0r21fzMFtO4g?=
 =?us-ascii?Q?9p4d00PTZxo68g4I69ZsYLY6MMZjLqo43CyCcNYT231yyP8LdiWxMlwR0MF2?=
 =?us-ascii?Q?cvtdBXq9+YLHwdjgBzwPGXnqHO8FtjFDaPp2XPsemamCV/O2WjvTEEWGss1h?=
 =?us-ascii?Q?O7eUV47ZZ50ymGVOWAKlD+M92KwDjGZqr834ajyd5q40rMebdegc2fMy2V7e?=
 =?us-ascii?Q?G9PoJNpDechVhsox4sVJAg3CyNiDlonFPe8L0s0hj9Lvrv5t6qMuxsppXbEP?=
 =?us-ascii?Q?EE0yw9qHP/5ShS86B4YaBBoGcOJDjrd3SRtF3Lf6BgqUt3tXVGZIu6obuYtG?=
 =?us-ascii?Q?yrIWQF280RZWzeLN1jdDVco8dQWO614LNC6kFQYOZ2JjHfpRbDhm9AEVFU6Y?=
 =?us-ascii?Q?DudVYvQFByoqvrWngVX46B0B7wiR3OA6jtHT+R11+aC5CTumZJuC2br/67F4?=
 =?us-ascii?Q?6ZkmWjBuiJ/Ta47MdfHr8dUqCaZIWDsmFx9xnzJ275cLeUzD22Q82mjcXVG0?=
 =?us-ascii?Q?v4gOeZ4LEnI5hi2JhiW3zEihYBZx9we1vyaCG0zxyUxp9PSB7s0UXNBtXZ3a?=
 =?us-ascii?Q?ip6bkGdJm4Bh3nyFojW6imedjKMEYMEMsKJFB+yxE9fZ5XtLkZyxhp+mnkYL?=
 =?us-ascii?Q?MzEPKDNBy9hVOpKVHeKV4fIbNIyLWD9AyH78yGaAkvOgIB5S81JHL49fijbS?=
 =?us-ascii?Q?04VYxWgssENGRPsG2IcDEV1IdjZHpg12L4qjP0temr3Tehs3wPElIoxc7DJF?=
 =?us-ascii?Q?pYxo3YxUmRQX5sNVdivQvCdaiaAFuN3JfRncw0etjfuLYmp5hUBnQAilg8Uf?=
 =?us-ascii?Q?YGkjqLWo5EAXDJdVa17zC/fjp8vMlx3JqGLsD5jFjbooaSnJZk13pSi+81T4?=
 =?us-ascii?Q?3CDVw+6txj+p1cnxxDTrphsr7ea1GSCFhyqQ9qoVTtzYBOayAIths7zwWSCH?=
 =?us-ascii?Q?BHZUKvMng06UkZ3ruDwmPyp7CIQIEKXGQEMpqRYqndKB+3lISJyhUoQexNlr?=
 =?us-ascii?Q?OpCyWhkFIBdAIRmpM/lHYkWawf0FjYJw0ftsyMIl6PZpC95gdC6hxtRV3NJg?=
 =?us-ascii?Q?1ESN+M6gQzD4w8acBU/GEUNjd+qpRqJC5USl+QAUP/5wFohO6x4ciHnCbLvZ?=
 =?us-ascii?Q?NDdpiQv2xTRiAlZKbNdhs1tzLSVOQQIOPyvG3OzZB+IpSAQB5HB56mgMaRcK?=
 =?us-ascii?Q?rUEDhAwyFAZoqYcR9aEx9ONlcSm/soKaFySqq+KBCJjI5zwV9mtRvN/jVNhd?=
 =?us-ascii?Q?r32L+qZ06fcMSBc7Ts2NFBuk4rTyMJpWztSXawFM9juhQaPwXCX1CS1PwevV?=
 =?us-ascii?Q?G0e/WAP9qeMtLfR0hmiFpz0+Ou4FHNBpKrdzrJucqcRjiFOzR9ynTOHGk9Hm?=
 =?us-ascii?Q?MJWUN1C3FhAZnbuL9Nsa5etwMBdMFacWJ0wi/sxVtbtGJMpdcmtFUj9zXt/u?=
 =?us-ascii?Q?pgAtBkF+E9tEt2oFnEcLkPIdL0GhryLc2dTHf6ONtztJGpqwNUuS70MSKO3H?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cBOhNCTHLbOs1CWLmt4W3nkwINHQsRSIVD5c72WSqOcivKwsnw3eDYPWN5ovHTSaLXDRDkzQrRJIODrKRn3dMqjmH2So/kFQSPnuRPpq3BKpwpRyOSHfrbYdyFFs5trSY5b3+QPFkSWbH0hvhyw3g4rIZqnmQx+Urwx9vsXsbwzUq3pli+uQAJvXoQ2gzFwUaYyKPZMFuo+bJJAal9VlCc8XJZLhLtBgUEFxrlenqaIAuxb8U8Ofq7E5VVpPpAtkQOQwlEY5o7VwGbudkueS5Yuyx+3joVDfqAVJ/tDWW3rpiDl2v4ePCRhTOvndRfYVAX9HQqIHYj/UrLlE1rnRvsb7yZoYNNQp37zWHr70xsQb19Or9i9bkBCAsvIu4gsfqZYsMcACo68T+a6l5AYaVBGCmN9CrW9SiZNAYzFRJs56obw6+PcuJdhu0JPpUIeQ1JEMqWPSzR2fmcIaiSX1ZTn7UownxnPqz52aNb6drzptTMtdp0uZOOuDJtOhlf76psmGQWhZIj3ReSzFNXihQUtLg79gt2ZO2aoL7HQFaJUL6BkXJWnlHYB5eaLqGij01IbdjD+FxZLVvPdQ0ErTxvLjoot9szmmg4Ory/aj3hay5jTc2p8eqVTLxhGT6U8O02AyIPu65H+xjH4bJhGsmqcouDG6W4Ppwsab1kiTiBL2a+HqeX11qsxNDoSkl0qWKu5ifRgzjo3CUEgxWHmu6siDtUHtfyzuLo4ZTW3wWWQMD8o2yuwTIbDBbHl0Ldg9NqVZ2Hv9uR4/rTiKeV0qSRRIMPeLjIH8DJvLj9013kGnQyYkkD5NNNpGHFWDYrSeq4OTbkjGT3fBMgoZPH4Vyo0Zvh5zAMkDNynyrHmISTi+2q+n5WJIGPCmIRF5WcyncP7pQyzjj4HW8zkDSjNNrA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9067642-052a-414b-326e-08dac4314df1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 22:08:46.7221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHDIe6OBMRYKSi3M7s2DRf1qGOdWnTiWZV7DA0z6Yvhsd4yQ+v2wAJ3o3WTl7mmNguhCX25KM9RIIlf2mqJaf7S8hZTrN2xf4YXK/2m9imc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110150
X-Proofpoint-ORIG-GUID: FklGPhwafZ5XGglXTdsmfMwcVmxDVWeU
X-Proofpoint-GUID: FklGPhwafZ5XGglXTdsmfMwcVmxDVWeU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> Hi Jan, Amir, Al,
>
> Here's my v4 patch series that aims to eliminate soft lockups when updating
> dentry flags in fsnotify. I've incorporated Jan's suggestion of simply
> allowing the flag to be lazily cleared in the fsnotify_parent() function,
> via Amir's patch. This allowed me to drop patch #2 from my previous series
> (fsnotify: Protect i_fsnotify_mask and child flags with inode rwsem). I
> replaced it with "fsnotify: require inode lock held during child flag
> update", patch #5 in this series. I also added "dnotify: move
> fsnotify_recalc_mask() outside spinlock" to address the sleep-during-atomic
> issues with dnotify.
>
> Jan expressed concerns about lock ordering of the inode rwsem with the
> fsnotify group mutex. I built this with lockdep enabled (see below for the
> lock debugging .config section -- I'm not too familiar with lockdep so I
> wanted a sanity check). I ran all the fanotify, inotify, and dnotify tests
> I could find in LTP, with no lockdep splats to be found. I don't know that
> this can completely satisfy the concerns about lock ordering: I'm reading
> through the code to better understand the concern about "the removal of
> oneshot mark during modify event generation". But I'm encouraged by the
> LTP+lockdep results.

Of course, I forgot to append the .config section:

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

>
> I also went ahead and did my negative dentry oriented testing. Of course
> the fsnotify_parent() issue is fully resolved, and when I tested several
> processes all using inotifywait on the same directory full of negative
> dentries, I was able to use ftrace to confirm that
> fsnotify_update_children_dentry_flags() was called exactly once for all
> processes. No softlockups occurred!
>
> I originally wrote this series to make the last patch (#5) optional: if for
> some reason we didn't think it was necessary to hold the inode rwsem, then
> we could omit it -- the main penalty being the race condition described in
> the patch description. I tested without the last patch and LTP passed also
> with lockdep enabled, but of course when multiple tasks did an inotifywait
> on the same directory (with many negative dentries) only the first waited
> for the flag updates, the rest of the tasks immediately returned despite
> the flags not being ready.
>
> I agree with Amir that as long as the lock ordering is fine, we should keep
> patch #5. And if that's the case, I can reorder the series a bit to make it
> a bit more logical, and eliminate logic in
> fsnotify_update_children_dentry_flags() for handling d_move/cursor races,
> which I promptly delete later in the series.
>
> 1. fsnotify: clear PARENT_WATCHED flags lazily
> 2. fsnotify: Use d_find_any_alias to get dentry associated with inode
> 3. dnotify: move fsnotify_recalc_mask() outside spinlock
> 4. fsnotify: require inode lock held during child flag update
> 5. fsnotify: allow sleepable child flag update
>
> Thanks for continuing to read this series, I hope we're making progress
> toward a simpler way to fix these scaling issues!
>
> Stephen
>
> Amir Goldstein (1):
>   fsnotify: clear PARENT_WATCHED flags lazily
>
> Stephen Brennan (4):
>   fsnotify: Use d_find_any_alias to get dentry associated with inode
>   dnotify: move fsnotify_recalc_mask() outside spinlock
>   fsnotify: allow sleepable child flag update
>   fsnotify: require inode lock held during child flag update
>
>  fs/notify/dnotify/dnotify.c      |  28 ++++++---
>  fs/notify/fsnotify.c             | 101 ++++++++++++++++++++++---------
>  fs/notify/fsnotify.h             |   3 +-
>  fs/notify/mark.c                 |  40 +++++++++++-
>  include/linux/fsnotify_backend.h |   8 ++-
>  5 files changed, 136 insertions(+), 44 deletions(-)
>
> -- 
> 2.34.1
