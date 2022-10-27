Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71966610552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 00:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiJ0WHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 18:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiJ0WHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:07:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328349C233;
        Thu, 27 Oct 2022 15:07:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKVlfU006899;
        Thu, 27 Oct 2022 22:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=idYnoK7aFfmeFGEKmZEqLl67tyUSMyhzmVExRUkD0W0=;
 b=R/GYe5e+7s+bF1jSu0JwxoBZyyfcLOLX4xsEUPaiNM6czO6R5xPA8wNeFn9icec2Z1Rd
 l22pRUFcUfubRJMTRa7A7Kqd2ARp5LXQSK8z4d71u6HmKnh2z7S63APtE3m3sYxE6naE
 IdEoahcirGEwqyjM6HsVq5aLSWuJpQQlhywRRIR1ckxTh4tyAaWL80icXFgH77k4nNAe
 AMGIUxfvziPHUwtXUhzxTUjE30BzBTugpiGN+Cpm5gSAMK5xtwgQSRO7LfH9VnLKBg9u
 EB5qrrYn5gWmlXLLdIgYEGPeCZ3J5GyPiguKa2nyALFhCC/lP59heZ5KaLxVYR/IZ9QY Xg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfb0akj47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 22:07:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RLZD8J017612;
        Thu, 27 Oct 2022 22:07:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaggxr16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 22:07:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9omPE4eb5Yy7E546k5XhqUkk5x4GPG80gDxMaqh3WiRWYsRCLDCJPkhVGzqEzI3fzW6zyrsTjZZzZa3Wg0DU4ghv0n8AWASyFFrIX0etUaUZSX60djl/jYZn9uY59BKEOtwmNBD2GgVUVJVf+2lNxbbdNF7zNDA9YO5SvACJGeDN6WSLVA+/yKzBUXwrZnP/aCZGfzWktfvnhJqlpMM7D7MjCm6r9q6nIyxprEqKwDTnbR4KJoWz12Dsa/a08JNLKc0njd5jVH4YPy19Fc3U4mkisTfiPlRyfA4ckzt16qfIFq3NKFB2SYwAS8q0DW9K7mgbmD+OtYJl7TF4IyLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idYnoK7aFfmeFGEKmZEqLl67tyUSMyhzmVExRUkD0W0=;
 b=hEoacNSz+qbHI0TP1+2ei2JqmA1CCM39GFW94u69DxSxaiogXEMh/u5c60rrKPN/I26cW2knai6cL5UBvPousLd5eEr70HdfpthlxYfJySMn/f9BC/E/Vnw5UkzBlXn0aGgSXVu3V6TtuzeLn9oJWBuARaED0e1zhCXBBme1iVytzoUzBfChkjUpXkn/PD9A1eynykS+OVfnj8D6pD7MLPjWJ/O57ZQjIUHgs73jDgyxP1pW0pyzx8zBG/67w89D6uM+rjfPRjXER16p/2Y0uhddwRDfRF5Vw/jIm6BN0nBVRDybVqBrxcXiD5pmcI38veA1CKSZol3CAex0wFZAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idYnoK7aFfmeFGEKmZEqLl67tyUSMyhzmVExRUkD0W0=;
 b=zFdlCzpUZXrBGsEMLOT1sedOAMIatWrKIzBVATeCgpwoozzRcmS69pQbpgq0srP/hPeAhOUADA2t/PWhCiGkkM3KbsHRZqKvpE4IWKeSfB9T5Wa4uAZ8AB+lafSMYTRwtpzf2j+ZwsbIvt70HnqfbL1jWYOhO9Ma4nJQLca+AJg=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SJ0PR10MB5551.namprd10.prod.outlook.com (2603:10b6:a03:3d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 27 Oct
 2022 22:06:58 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 22:06:58 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] fsnotify: fix softlockups iterating over d_subdirs
In-Reply-To: <CAOQ4uxhwFGddgJP5xPYDysoa4GFPYu6Bj7rgHVXTEuZk+QKYQQ@mail.gmail.com>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxgnW1An-3FJvUfYoixeycZ0w=XDfU0fh6RdV4KM9DzX_g@mail.gmail.com>
 <87edv44rll.fsf@oracle.com>
 <CAOQ4uxhwFGddgJP5xPYDysoa4GFPYu6Bj7rgHVXTEuZk+QKYQQ@mail.gmail.com>
Date:   Thu, 27 Oct 2022 15:06:48 -0700
Message-ID: <87czachqfb.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:130::22) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|SJ0PR10MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 5153559f-4e24-4533-5637-08dab8679142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dz4LFqQM4+sALXvJdMY8gjqjBOSAqMsMcqP2S86VrZbruPAGMlpXB406QuUcEcAH1C8CR+LZ95yrPnAwXweJankonZmV7BpxReatDgCvJyVAV0GbT19KjcDIJt/LnVdPIFao8b044oj21+0g3MxOv6x/fP7j/nxXyeLSobSCkTBdAAl9lBvaEaSgTSxJLjUOYtGXx94Arj6P27j479XDstrfI6OrmZT7NJtMs+obSRXJe7s/OqxrxqLn3SJIwI4q0ck0wShcql5A1Dotx2Mrd290ikdkwTSqR0zdVJKW/xDjwd1emu+685kNEfVbIznUCbPnHBU7493hqYxXKBNgtFL5R+dvMcEFdmNNoor6Bp6xNH4Aqm2HxVkZl62nOR+VAySduuy+Fo53wiwTxJSdRcnZJ21Qf1OzTwYTURbJUnnPliHqW18O4+kfQ5clJyIbx/e8V3xBpzMbFAw2u5WagXRwwIhUDWRINisXZnV7IgnRYLCygcIpZg7QrzORI40LXu68nnPLE114Ui8XMDtsAX3lnet+shGqI9qMF9on0yOEyw4524BUNcPDw5zATEL73UkrNx9Ck58zd1MefNFanzyWWIh5Nv+/ROl02rDnkJIUfoRbkLbZilrYs+qsyQfawYs6v69KzbxjCIog1KBfqVlPsJXjd/QewbtI8s9QLOfFmp4IrmYJDSLuKPC8J1BqYblZElPUV/F0sQtXNvN8Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(66476007)(36756003)(2616005)(6916009)(6506007)(2906002)(66556008)(83380400001)(38100700002)(5660300002)(54906003)(86362001)(41300700001)(478600001)(186003)(8676002)(6666004)(6512007)(66946007)(8936002)(6486002)(316002)(4326008)(53546011)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q+fXoMuhbgTvIqYeZAvS8Oah0vfK4nWNIhRdYeuwRIi+mYLBMwSHsNzd9QWB?=
 =?us-ascii?Q?e42Gdxn9dITJ/u1A7W/2vB6gyzIyfYkWGuerIzS96R0HA8dqIPUR7mzMID1R?=
 =?us-ascii?Q?4kct9pOn53j+gCJG0RBpa32lpRSbzBtGWmeBUN+niHbeHT8Kyf5IEFO2fXxe?=
 =?us-ascii?Q?m6aGLtXpdKHHaz4QjYHkghy9U7pVLD2uF6VhyFeyqOdrlZxTLL9AIz51Wfdk?=
 =?us-ascii?Q?0sPP2hJfq0qQ4RaGe4d1wnY8XGpByqifiD8eE2ZsLGau62HRbi3Y+xlXBUM1?=
 =?us-ascii?Q?xRZYrJOWeRWRMnbHhs5isGo7N+qB80CgOvnyvCMd1sXpg9X9DXzpJ4AEknXB?=
 =?us-ascii?Q?6LsiEUnaymUrXMANlMsRQrrzJnH7BOBDmVPqlcdzwZk54yP0q4sYknHHDf5y?=
 =?us-ascii?Q?bo+6HWdV15fgoHhqjXIaSpv5C2Y4ztTclpTOHMK/dSa4pfZYzl3RQc4cVqX6?=
 =?us-ascii?Q?hsuswFbDOX/Wr3yY/rVwXcIfZk1811E+Ve60vrvLF3gZt+VgnDwljPPxYgFV?=
 =?us-ascii?Q?oiFxaZm/Pvvrbuk/6KL59DZ+KymkrTvjWUiggXWccNx2Kq8XSMWvs1xTKU6c?=
 =?us-ascii?Q?dDWlAjZE87oVLs0vvyZaWNyyNgBdrkmwn0bktja5i0MemdnTzoNChiIZCnac?=
 =?us-ascii?Q?lENtDnAjSMhZ9jQw8yoE4xI3PELOdyBxeroFqwHcKgouk7Iy4+NEQVxQVhHP?=
 =?us-ascii?Q?nwzuY6EmBC4LI0nQfCT/RphVF2wnrF5pX9DwqthSitcIVGF8QyZKNr3u3s41?=
 =?us-ascii?Q?HH6sVZaGM9NJnC6fbq7AeRHV2VQsRvB4g4ObHwdigaetsDciToB80DwttS3x?=
 =?us-ascii?Q?Osm5Ay66FgGiG6m4rBGmvEo5BP98baTxWnj6XQZxovlV1b5fegtC+nkXYhP6?=
 =?us-ascii?Q?mon4XYWEaLIMgUfG9iayOSKlbHL/SSnRKvil17HSxJLbf773qelzeZZnjv+H?=
 =?us-ascii?Q?0vTS5+DqR5dj+WtFM9iZuyDFHJ4zIFRo/zwdcq4nC0TKjsxYSWRUS2YzvnXD?=
 =?us-ascii?Q?Vh89t8mCZEMZeaZyklg376ot1PxHXM0+xP9PHfCXI3wNDVb8y4pLNFTQm9/7?=
 =?us-ascii?Q?1jiIC8fXHfhmvRA1JDAX1HuWUtfXJyHE7coQMTP/BYwzOq3RGw8WmF1c5qza?=
 =?us-ascii?Q?2ee7ktNG/WCxWnZ8t/dgNqd0VEXY2bpTd2Dtj3XmH1QgsJTJGYwKpscwl8uy?=
 =?us-ascii?Q?TM6FzcGYm1w2/8YKcyt9q7Nxgs7l3PdWO4eRCeAi9PnBIij09A0F4+1ooLVr?=
 =?us-ascii?Q?d7UGCOnpsbDASzhC6GN0UxEFzQpfXBPIUV7UXCKjK4lin3I2yFw3ZhmmTpgw?=
 =?us-ascii?Q?yIapO3Z7i+fmiYNadtsGs7mADzmDvJ8HO1I9gr7ANaTmBv/WmMVh8vfa4V51?=
 =?us-ascii?Q?MCAN/qJ3RQ9b2UkAtzxbOh4s9c1Gm857bTiKuzlcHlXeuW1Gc2Mqk7gy+m9I?=
 =?us-ascii?Q?hWwXD7XPKybvUO2NSC+JC/D41yil4/ndxSxllcSeMo4tiNdQeKJiF3A1gdp5?=
 =?us-ascii?Q?1UfxN/LDcbOIrEADd9Vxtt01RZz+g6+9pfkp0NTIfc4Jlu1ntHC4skUmOPnd?=
 =?us-ascii?Q?EwAfjF+50AtIwW+8nxHMXLlM7KiV1vfCEtCXbBCQ1TlvqwWwiEZjSYfEY08E?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5153559f-4e24-4533-5637-08dab8679142
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 22:06:58.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW1GoI4L+jMjq/6OB7bOqVDsFjuHAz+dcRG9p2s0422zgLY0dMNgCXm6aH1Fxzump80COW0SKEgeBegd95hWLjr/h7BQJP3yDC7J7tBNM0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270124
X-Proofpoint-GUID: F-MxDzEN7zyUMMzJBKjZsKkVsIXx2c9q
X-Proofpoint-ORIG-GUID: F-MxDzEN7zyUMMzJBKjZsKkVsIXx2c9q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:
> On Wed, Oct 19, 2022 at 2:52 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Amir Goldstein <amir73il@gmail.com> writes:
>> > On Tue, Oct 18, 2022 at 7:12 AM Stephen Brennan
>> > <stephen.s.brennan@oracle.com> wrote:
>> >>
>> >> Hi Jan, Amir, Al,
>> >>
>> >> Here's my first shot at implementing what we discussed. I tested it using the
>> >> negative dentry creation tool I mentioned in my previous message, with a similar
>> >> workflow. Rather than having a bunch of threads accessing the directory to
>> >> create that "thundering herd" of CPUs in __fsnotify_update_child_dentry_flags, I
>> >> just started a lot of inotifywait tasks:
>> >>
>> >> 1. Create 100 million negative dentries in a dir
>> >> 2. Use trace-cmd to watch __fsnotify_update_child_dentry_flags:
>> >>    trace-cmd start -p function_graph -l __fsnotify_update_child_dentry_flags
>> >>    sudo cat /sys/kernel/debug/tracing/trace_pipe
>> >> 3. Run a lot of inotifywait tasks: for i in {1..10} inotifywait $dir & done
>> >>
>> >> With step #3, I see only one execution of __fsnotify_update_child_dentry_flags.
>> >> Once that completes, all the inotifywait tasks say "Watches established".
>> >> Similarly, once an access occurs in the directory, a single
>> >> __fsnotify_update_child_dentry_flags execution occurs, and all the tasks exit.
>> >> In short: it works great!
>> >>
>> >> However, while testing this, I've observed a dentry still in use warning during
>> >> unmount of rpc_pipefs on the "nfs" dentry during shutdown. NFS is of course in
>> >> use, and I assume that fsnotify must have been used to trigger this. The error
>> >> is not there on mainline without my patch so it's definitely caused by this
>> >> code. I'll continue debugging it but I wanted to share my first take on this so
>> >> you could take a look.
>> >>
>> >> [ 1595.197339] BUG: Dentry 000000005f5e7197{i=67,n=nfs}  still in use (2) [unmount of rpc_pipefs rpc_pipefs]
>> >>
>> >
>> > Hmm, the assumption we made about partial stability of d_subdirs
>> > under dir inode lock looks incorrect for rpc_pipefs.
>> > None of the functions that update the rpc_pipefs dcache take the parent
>> > inode lock.
>>
>> That may be, but I'm confused how that would trigger this issue. If I'm
>> understanding correctly, this warning indicates a reference counting
>> bug.
>
> Yes.
> On generic_shutdown_super() there should be no more
> references to dentries.
>
>>
>> If __fsnotify_update_child_dentry_flags() had gone to sleep and the list
>> were edited, then it seems like there could be only two possibilities
>> that could cause bugs:
>>
>> 1. The dentry we slept holding a reference to was removed from the list,
>> and maybe moved to a different one, or just removed. If that were the
>> case, we're quite unlucky, because we'll start looping indefinitely as
>> we'll never get back to the beginning of the list, or worse.
>>
>> 2. A dentry adjacent to the one we held a reference to was removed. In
>> that case, our dentry's d_child pointers should get rearranged, and when
>> we wake, we should see those updates and continue.
>>
>> In neither of those cases do I understand where we could have done a
>> dget() unpaired with a dput(), which is what seemingly would trigger
>> this issue.
>>
>
> I got the same impression.

Well I feel stupid. The reason behind this seems to be... that
d_find_any_alias() returns a reference to the dentry, and I promptly
leaked that. I'll have it fixed in v3 which I'm going through testing
now.

Stephen
