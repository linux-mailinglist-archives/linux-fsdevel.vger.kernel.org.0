Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5E390850
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 20:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhEYSBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 14:01:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54156 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhEYSBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 14:01:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PHoPps090315;
        Tue, 25 May 2021 18:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+NvEEcCLTRrCBT5qsK0fhovsYsUppToFGcVScahRyTc=;
 b=d7VMdquS78yFsVLXwXEv8jBDElYXkis200HjyBmHmmcUT0vcMuj/at0R7j39bZuOHuTp
 O3XpaSOR5M+LjY4zLr18ExHw8BMW34aF8hDKOYfLI8eAJg/nXV/2La0g9qrqTOqH1GwK
 CIAosADlRwA0+eZ2mT2rnshQkd/8P/eJOjzI5J7WtR2gpRUHBmX2SKV3aWEaoZoH4Qj8
 589WAboQva0Afif3rjYgAEfubElrrRqieaOE2khjYMDZ/VitJn4l3kx4j0lzFmJ6L5Wb
 pgMVDPeJGsRBs8cMzS4ljx9g2yT0iVFpyKIO36VFMG/hEWVZKNaapblEP4a3I4DhJCvi VA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 38q3q8xbh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 18:00:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14PHo3QV064031;
        Tue, 25 May 2021 18:00:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3030.oracle.com with ESMTP id 38pr0c0u9t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 17:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4DQA/RBVff7n36QYWoLGZiIVkQMdSfbqlNvif/Y7i5huTtkle08u9MMyigpurPCD3tdH4NgfhV8O5fHbAyzSu+O3VevITgtOxJzCOe7hTnic6Pm93xoDIkWEDJnKd7ieD7rYdvtbpx/nJqrB1yFMgLej3vT6+Ah85NFe8Aj4Nc229nx45Ibj8MwDK+h/euIHj3fsHEuN/vxHnBcMYwqLp4ttiLvpzw4EnFaMenW5BKXGshdJmHBBZidXVjQRuFNY99FD2cEKTbuI5mBl+HnuC+4P5zdIQfE2qWyuMaW2lP+IVTgpWi47rYA68if+s84PD6aUVw9qcT+bfwE+Fq0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NvEEcCLTRrCBT5qsK0fhovsYsUppToFGcVScahRyTc=;
 b=cH1tThR8kFuWbhH+UvmUBNUVN7pNowyU8UZzmO81jWZan62a3xOCY7FQa6NPZzp+V9WzPsFfn71V2prB8s1ARVsoD9smzIRBalVbTQXDMZQY/+DAYmyFI2pDHBdwEVfru89ZgPclJ/f8KCA3ouJN9UQ153k+ytjgCywfvu7c9Ffca6OEnT2DnOSsvGJKwvYpy+Lu+S/Vff2pLdILMy+ZawaKtUx9+U/arDquX/KhHDh+ulQ5NEzp6EahhvtvILfbzuEJgIm8NfXjLkydkvJahaQ8Gd//knSmXnX9WP5hBoLhLOG0nhwKSQ6mhzw9Kv57QCc2yeUT0D/trMirLWurLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NvEEcCLTRrCBT5qsK0fhovsYsUppToFGcVScahRyTc=;
 b=pb3Xo9uvnYORLh/WlqSoTnnlIdTftIa1r0xd6Ds1NN2khgpaKV2y/lhlA99usFG2eO9zI4HUTPOJtgWXLSp0Fzm72/wZc8aF+jH2L0nIAuGlbMDRSNd4Fqm/iG4LJmRdgbXkvO6spvwTRSfcKO+i+Hz0qixATA/LselCYRIP0Cc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by BYAPR10MB3653.namprd10.prod.outlook.com (2603:10b6:a03:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 17:59:57 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4519:4046:5549:95d9%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 17:59:57 +0000
Subject: Re: [PATCH v2] ocfs2: fix data corruption by fallocate
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com
Cc:     jack@suse.cz, linux-fsdevel@vger.kernel.org
References: <20210521233612.75185-1-junxiao.bi@oracle.com>
 <35a1d32b-b8d7-ea9b-d28c-6b4fd837605d@linux.alibaba.com>
 <8aa90f5d-e4db-5107-1d3c-383294871196@oracle.com>
 <21d8b289-541d-50f5-6f86-de3ee69c56c5@linux.alibaba.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <35283832-3294-19e0-6542-d1f925711fe8@oracle.com>
Date:   Tue, 25 May 2021 10:58:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <21d8b289-541d-50f5-6f86-de3ee69c56c5@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [73.231.9.254]
X-ClientProxiedBy: SJ0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::9) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-159-226-235.vpn.oracle.com (73.231.9.254) by SJ0PR13CA0004.namprd13.prod.outlook.com (2603:10b6:a03:2c0::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Tue, 25 May 2021 17:59:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1da72976-6df8-460c-192a-08d91fa6e838
X-MS-TrafficTypeDiagnostic: BYAPR10MB3653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB3653EEEBEEBE16104F8CBD81E8259@BYAPR10MB3653.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yl+aZnNIPO7W0cMmcl5WDs5E9fhpuvBGncE1hoAvVNI7JG/GDAH0JGH6m7pjHUiLy9xV0JZzmbG3yAfiXp7cgMT7uiITDV3x+m5KS+Vt77XgMYihD3sTh71TGzm9EOAhPBuaNa3bkZvLfh+x37nKkig1WjbUeKVRcb12Gjqsl90/TXm3B1vUnPDS64z20yTmYIVazN695xM35WpzZlzX4vRXaur3YZT4Ut4hp1rREdsn9f5LGC27jVJxDvoxSEIVouhStNEXePE2P4jOQ2kVoLT+dliCYYrAAc04LYQn43LmtL0NZTIivixKg2+ynrA1iGLVAEZvW5JTswWCopxD5Bp+es45aKOJvlTr5Dx1W6YJs3vM7mldg4IvzF4oqtlnukPjymWgB2Ggozcc1MejBVF1Q58JslyE0OtYSlMG1BT9pwvekLYheUm0+PetSs+FuXi6Q8XPnkRssEKD0dyuu1ckJUxwjRuE/azXz/5/WxqR3/9nqScNFyiiSdMI0vyZo1uOA4pL45d5zvFt1MqtR1Xee7zF1FQTyXQ9iR/Dpgh0Y6HxIC6I7MFW86+s4npibjbeO4IoJDLgXygdeoCuEu+qBCF7iMtGd+jITrQDVHJApUNcn+5CuWvGeW7fQJgdi1KBDe11kXgT7okzWXnehOdOlSmll2kWwB0zjtqBC0Jzw9q06Ar6TyymBbUBYk25/EEXTF813SZGzlxO1HzlSboYScNP1zvwxiFR35EhgVmHBV8CZcjK0svATr1rOM3qJ+qaPuaU10vY8b6ChPGYikpqClCTgyjETPld9UsEk1ioNHMa0uoMiNEZuXzvinT9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(136003)(366004)(66476007)(66556008)(6486002)(956004)(478600001)(44832011)(66946007)(16526019)(186003)(5660300002)(38100700002)(2616005)(53546011)(7696005)(31686004)(8936002)(316002)(966005)(26005)(8676002)(36756003)(4326008)(6666004)(2906002)(83380400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VGV2MEZqNDFwbkFGYlpVbmpYQkRxcGxLZTBrK3pwSWNGbFh5aXZCVmRxaEZN?=
 =?utf-8?B?cHZ5MU9mN2E3anU3STQ5YndZV3RsK0Jhamx1U0VhWThpVGRRSWdwZ241Ukdk?=
 =?utf-8?B?eWxqUzBZR21oTEY5QVVleGloZ1lsYk9icFdSS2ZQYUliTHdiV3pBcHlVZEEz?=
 =?utf-8?B?YWhzZEh6ZlJhTEx1ZFd4UTMxZi9tNVM1MUNFMG5JSTZ3OVJsL0d2OE9jRHZD?=
 =?utf-8?B?alEzZTlUYkVKaWxvdWowNFhDdjBlNUZrL3pCNnFJL3dtSlhwSWlURkdmNXFB?=
 =?utf-8?B?WEVvQnVkVXlhUCtvck15eWI3SjFuWjJkS3lDOGs1dWhHQm1GNGtuTEwwbXND?=
 =?utf-8?B?cHY2Q0o5M0JBOWtrUWU3MHVqR1dRVmFYVWo1UHJUWjQxYThnajZOUlE5UlNs?=
 =?utf-8?B?eS9EdndDc0h1L3pGRXJYWGhVUHN1Wit0Ym1zVFJ1SDFzRU50OEtWV2F6anJp?=
 =?utf-8?B?T3duMVpENDllaVFGN0dLblR3MXE0KzJHL3B2bVNSZ0JuaVd0ZzJyT3dTTTdV?=
 =?utf-8?B?L2pTRnNHV2l3WTJPM2kvR0FxTU1BMjhabG5Jdlc0S0dydUZOaURkdEdZRHY0?=
 =?utf-8?B?dDhrVkdRZ0ZISC94NlNuZWt1TThSSFFvQkp0UXZadjRhUUhrZTg4am1aSnJF?=
 =?utf-8?B?Nm9McHRkTzI3VzMwTm1zZEdXODM3UlNKSzFmRnQyWFIxTkkyU2NOUGFhK3Ax?=
 =?utf-8?B?R0NCOHJSbmlob3pNQzlsOGpUYmZnd2dEaE85L1orVnZRc0RhZCtxaThYcUxS?=
 =?utf-8?B?SlltdmEweXQrVWhBVE5jQkpCOVRob2RWRmxWRmgrdjhaVThvU2JVZllYV21o?=
 =?utf-8?B?UWRwbWwwYUEySGFpQU5MbW5nZUtmMFRYdExlQXpzN3dMd2ZmZERvdHAxM2Rx?=
 =?utf-8?B?MW45NUVOcytBaEhWOXd5YnJ3bU52TmREblJaRHFsQkVFT3R2Ly9CR1FtVkNz?=
 =?utf-8?B?Rm85YUNZV3l5SCtrbVhocUN5SmRqWENmS1pZUFc3T3FON1VmWlFwS3NyeEQx?=
 =?utf-8?B?djV1eE9zUkZFellmZ2dmQmJ0R0tveWs4aTVyYk1RSkNhN3M3bjJ4cjl0VDBn?=
 =?utf-8?B?dHcwN3hoaDR3WFFkWkswSnZTSlZxVXRaOVZUY01JSlphQW0zVmRIdndzdXhz?=
 =?utf-8?B?UkxyNFVJYU9yMXM4MXdrb2E3clUzT1lHcllXY1NxY0VxTHVXbHZ6TWI5bzhY?=
 =?utf-8?B?UU1acHZLSEdQYTBocm9pUE5WbWpnNkhkWUhJbWJTd2NtSzFjYUFXVWVHckhY?=
 =?utf-8?B?a1BPbVVqZFcyRHUvb3F5aThRMGtoUFRldXdhUG4wblo5cWVXSCtLQUpTcU1v?=
 =?utf-8?B?VmNQUGYwUjFYTm10T3pYWDRVK2xHODJjL3hQY2N2enEzTGw2aE5BV0dZaUNW?=
 =?utf-8?B?a09sQlF4T0dUZkRuRk1WR25JUzhYTVdnTkZPWmZ4Q3RaNmtBV3QrZkMwZEJa?=
 =?utf-8?B?bnJ5dmFDRmdiNHRxY0hCRmZCeHN3ZEpPOFk2RnFMNmtPM1ZYUjlia1ZjRWRi?=
 =?utf-8?B?b0JNcCtkMllVN1FjaFB3WXg1WGF1YktqU1puZktNNmFMMlBObTZoaUFMb3Vh?=
 =?utf-8?B?TDVuMFFZcEsvUjlpbDhBUXRxaFBSbmhXajhvQWk1QkpvbkdwVGxFZGx6eGp5?=
 =?utf-8?B?QVRoc0JuRGNNRnpqMFVtd0dLa3ozcmpWUGNCYkg1UjNQbWM4UllwRFA3Tncz?=
 =?utf-8?B?TVR2S1kyV1B0VGh6RnpHZ09oTjFRYXphMWRuUnlvNWpScnV3bUtRVndNUHhL?=
 =?utf-8?Q?+lKYZjx/fjk7ZgXk6qxnqOHgEnu1gTw/DsI39Hc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da72976-6df8-460c-192a-08d91fa6e838
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 17:59:57.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZckniExi6BCBESai+ZaF70EK/yePMl2LFS/Fip8tEKV9ENh4s0PTdGhHv1GG1mj0QSmwq3V6UbdXbP5iMntWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3653
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250110
X-Proofpoint-GUID: PItMLnodI2iVSdPH8qUGRTpIBoj3rNG_
X-Proofpoint-ORIG-GUID: PItMLnodI2iVSdPH8qUGRTpIBoj3rNG_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9995 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250110
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I would like make the following change to the patch, is that ok to you?

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 17469fc7b20e..775657943057 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1999,9 +1999,12 @@ static int __ocfs2_change_file_space(struct file 
*file, struct inode *inode,
         }

         /* zeroout eof blocks in the cluster. */
-       if (!ret && change_size && orig_isize < size)
+       if (!ret && change_size && orig_isize < size) {
                 ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
                                         size - orig_isize);
+               if (!ret)
+                       i_size_write(inode, size);
+       }
         up_write(&OCFS2_I(inode)->ip_alloc_sem);
         if (ret) {
                 mlog_errno(ret);
@@ -2018,9 +2021,6 @@ static int __ocfs2_change_file_space(struct file 
*file, struct inode *inode,
                 goto out_inode_unlock;
         }

-       if (change_size && i_size_read(inode) < size)
-               i_size_write(inode, size);
-
         inode->i_ctime = inode->i_mtime = current_time(inode);
         ret = ocfs2_mark_inode_dirty(handle, inode, di_bh);
         if (ret < 0)

Thanks,

Junxiao.

On 5/24/21 7:04 PM, Joseph Qi wrote:
> Thanks for the explanations.
> A tiny cleanup, we can use 'orig_isize' instead of i_size_read() later
> in __ocfs2_change_file_space().
> Other looks good to me.
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>
> On 5/25/21 12:23 AM, Junxiao Bi wrote:
>> That will not work, buffer write zero first, then update i_size, in between writeback could be kicked in and clear those dirty buffers because they were out of i_size. Beside that, OCFS2_IOC_RESVSP64 was never doing right job, it didn't take care eof blocks in the last cluster, that made even a simple fallocate to extend file size could cause corruption. This patch fixed both issues.
>>
>> Thanks,
>>
>> Junxiao.
>>
>> On 5/23/21 4:52 AM, Joseph Qi wrote:
>>> Hi Junxiao,
>>> If change_size is true (!FALLOC_FL_KEEP_SIZE), it will update isize
>>> in __ocfs2_change_file_space(). Why do we have to zeroout first?
>>>
>>> Thanks,
>>> Joseph
>>>
>>> On 5/22/21 7:36 AM, Junxiao Bi wrote:
>>>> When fallocate punches holes out of inode size, if original isize is in
>>>> the middle of last cluster, then the part from isize to the end of the
>>>> cluster will be zeroed with buffer write, at that time isize is not
>>>> yet updated to match the new size, if writeback is kicked in, it will
>>>> invoke ocfs2_writepage()->block_write_full_page() where the pages out
>>>> of inode size will be dropped. That will cause file corruption. Fix
>>>> this by zero out eof blocks when extending the inode size.
>>>>
>>>> Running the following command with qemu-image 4.2.1 can get a corrupted
>>>> coverted image file easily.
>>>>
>>>>       qemu-img convert -p -t none -T none -f qcow2 $qcow_image \
>>>>                -O qcow2 -o compat=1.1 $qcow_image.conv
>>>>
>>>> The usage of fallocate in qemu is like this, it first punches holes out of
>>>> inode size, then extend the inode size.
>>>>
>>>>       fallocate(11, FALLOC_FL_KEEP_SIZE|FALLOC_FL_PUNCH_HOLE, 2276196352, 65536) = 0
>>>>       fallocate(11, 0, 2276196352, 65536) = 0
>>>>
>>>> v1: https://www.spinics.net/lists/linux-fsdevel/msg193999.html
>>>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Cc: Jan Kara <jack@suse.cz>
>>>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - suggested by Jan Kara, using sb_issue_zeroout to zero eof blocks in disk directly.
>>>>
>>>>    fs/ocfs2/file.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 47 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
>>>> index f17c3d33fb18..17469fc7b20e 100644
>>>> --- a/fs/ocfs2/file.c
>>>> +++ b/fs/ocfs2/file.c
>>>> @@ -1855,6 +1855,45 @@ int ocfs2_remove_inode_range(struct inode *inode,
>>>>        return ret;
>>>>    }
>>>>    +/*
>>>> + * zero out partial blocks of one cluster.
>>>> + *
>>>> + * start: file offset where zero starts, will be made upper block aligned.
>>>> + * len: it will be trimmed to the end of current cluster if "start + len"
>>>> + *      is bigger than it.
>>>> + */
>>>> +static int ocfs2_zeroout_partial_cluster(struct inode *inode,
>>>> +                    u64 start, u64 len)
>>>> +{
>>>> +    int ret;
>>>> +    u64 start_block, end_block, nr_blocks;
>>>> +    u64 p_block, offset;
>>>> +    u32 cluster, p_cluster, nr_clusters;
>>>> +    struct super_block *sb = inode->i_sb;
>>>> +    u64 end = ocfs2_align_bytes_to_clusters(sb, start);
>>>> +
>>>> +    if (start + len < end)
>>>> +        end = start + len;
>>>> +
>>>> +    start_block = ocfs2_blocks_for_bytes(sb, start);
>>>> +    end_block = ocfs2_blocks_for_bytes(sb, end);
>>>> +    nr_blocks = end_block - start_block;
>>>> +    if (!nr_blocks)
>>>> +        return 0;
>>>> +
>>>> +    cluster = ocfs2_bytes_to_clusters(sb, start);
>>>> +    ret = ocfs2_get_clusters(inode, cluster, &p_cluster,
>>>> +                &nr_clusters, NULL);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +    if (!p_cluster)
>>>> +        return 0;
>>>> +
>>>> +    offset = start_block - ocfs2_clusters_to_blocks(sb, cluster);
>>>> +    p_block = ocfs2_clusters_to_blocks(sb, p_cluster) + offset;
>>>> +    return sb_issue_zeroout(sb, p_block, nr_blocks, GFP_NOFS);
>>>> +}
>>>> +
>>>>    /*
>>>>     * Parts of this function taken from xfs_change_file_space()
>>>>     */
>>>> @@ -1865,7 +1904,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>>    {
>>>>        int ret;
>>>>        s64 llen;
>>>> -    loff_t size;
>>>> +    loff_t size, orig_isize;
>>>>        struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>>>>        struct buffer_head *di_bh = NULL;
>>>>        handle_t *handle;
>>>> @@ -1896,6 +1935,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>>            goto out_inode_unlock;
>>>>        }
>>>>    +    orig_isize = i_size_read(inode);
>>>>        switch (sr->l_whence) {
>>>>        case 0: /*SEEK_SET*/
>>>>            break;
>>>> @@ -1903,7 +1943,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>>            sr->l_start += f_pos;
>>>>            break;
>>>>        case 2: /*SEEK_END*/
>>>> -        sr->l_start += i_size_read(inode);
>>>> +        sr->l_start += orig_isize;
>>>>            break;
>>>>        default:
>>>>            ret = -EINVAL;
>>>> @@ -1957,6 +1997,11 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
>>>>        default:
>>>>            ret = -EINVAL;
>>>>        }
>>>> +
>>>> +    /* zeroout eof blocks in the cluster. */
>>>> +    if (!ret && change_size && orig_isize < size)
>>>> +        ret = ocfs2_zeroout_partial_cluster(inode, orig_isize,
>>>> +                    size - orig_isize);
>>>>        up_write(&OCFS2_I(inode)->ip_alloc_sem);
>>>>        if (ret) {
>>>>            mlog_errno(ret);
>>>>
