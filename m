Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0F30AC17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhBAPz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 10:55:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45275 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhBAPz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612195315; x=1643731315;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7NxcDaJ6QNOlvWkAICOlmOFpTpZEDXqJxv9Nh22d5uQ=;
  b=NgCPCQuYeUszI1iVfBgA7T8GoaxRdandVyq5H8PMTg78GIcg4eLqz3MG
   rGGZObjnPnNUi58qyrfRy2AHryX1/mcaGblYSDbm+QWd3xDkGY3ZsfPUE
   R5p3Dbd0P7xZ91T2nFqWkTL7NJRKbJbStkLVaz2UpXA7nV8oxCDETRbL1
   e13xnVaabae63hhSDhzqed4Rfou+r334oOpQGbFVSVxvJsOtEK1+JQsjL
   PhJW6YoBqhBKycOvw4Ni6DablKiz/AbTxsipJJD5pd16id9oQDCOY9qGa
   wf1hRYza/kMllTTzSEdweaf5OnYJz10npbeA/Tn/F7tz1bS0r2ssxUC4A
   g==;
IronPort-SDR: 5Vf+YYHM1BMVmmnOWb7l9KHBxxEiSc3jVOclHDkK31F4Eet7hHL60UNc7/AHSsV5/haQaoabX6
 Mry4iKy1aqZLX39BZoIBUtaN/Lw7o6Jn1jZtgwvmgMntkUlvXh6mBGgwYYQqd9A9hgcGcLbD7m
 uSDrL4g/j8fS/2ltiFSjTqbyEq4NQ6oLzikD8ihDtoZ0326Z26t1Xk4UHRh3Jxsk3vXXnZXUi7
 i62tz8km8T8CGlciMbEdVDHtvrgLgQsGhmSPSiQhkndiuIiK6VTrnf10J6N6GDXtEpQ9Cw4yjw
 bOE=
X-IronPort-AV: E=Sophos;i="5.79,392,1602518400"; 
   d="scan'208";a="262897374"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 00:00:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ2AMIq36CDMSnAnyaMOZDMvngFyDaI2z4lNadJzQIR0EyFKSBv6gO9ALeTeI3naBuTJBkorn56OL819AcMz96L5tMmHhkpsZxmW1zJwflYUDkVWK8DK2AMVyTBZg5Kqfe7SQn9u2ha4GfVnoAxOnFPHKGkZRRJrHe9M2thSRXcJ//VuhRye8Bp/XAQ9XHk19sFTsly5NFqSNHjoVDsmOcQz7yGNGJ7uc3IT82OImd3AcsbRZcwlAx4JU6kKTdMBtX6UKtuyd7hJx9rnlJwtboC6vLadTEeUz+oBNYjQjszsUtOZ+9wHAcnQuaaUL7aISXeMJZSzCq74SU1LKHHZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3qIpPSjtFetjU8wWNrqimNJEm3xjdETHACPkGSJVhU=;
 b=IuJ3Lr+5rmP+gZOXnNkDOAG7zWKGwzHNxSrmGm1tn13YWeARFthOFkdDTQ16La8DB+qcLRlILyR63685WjWC2voNzPlZdado5rcZbHzhQ8ZSQCABVYe3Yvk+6NEO6ziUGPpyvFJBCLl3H6GoT9mCDLTGaYWlYYmXyK6yuhfmHUD/BdUtAn6F/YIDXOAKBIVSfIYk598R2WSop7jVoAzPsXVzPGby+3mz6hVodLpRZpnzp4oexRYz+e7BOFP3znqXOgkggmQhoZOJszbUuPjqg1meUiOsiOddSef7Orrdgc4EABg/tHAKMmOWxn9AoMeFB/UkCaLazzEMP1jRS5i7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3qIpPSjtFetjU8wWNrqimNJEm3xjdETHACPkGSJVhU=;
 b=qqefVaM9CcBYdkBHRN3h7Ux8XvwuiNCog0fBUxxCtpKgrQHTd7N134MYh7sPg8EFgHJu6kQNOim/gCC5L+jEnDwObwyd2HC8unrFsgDkq090mRYl1f4srwOCFUmVvco3ysxJ3q6L27y6cVZmSDRMFPhzSTfccT7Pm5Kub5JSiTE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7323.namprd04.prod.outlook.com
 (2603:10b6:806:e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 15:54:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 15:54:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 42/42] btrfs: reorder log node allocation
Thread-Topic: [PATCH v14 42/42] btrfs: reorder log node allocation
Thread-Index: AQHW84rD6oYU96ZylkiU19rDK4c2tg==
Date:   Mon, 1 Feb 2021 15:54:16 +0000
Message-ID: <SN4PR0401MB3598F91AA78520BE1946E9EC9BB69@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <246db67fcf56240127a252f09742684cd30f4cfe.1611627788.git.naohiro.aota@wdc.com>
 <CAL3q7H7KYKgJgm2+C9WBW+F23tpdJukNZHQ8N-RxbyyC78B5xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cad4f13-fb13-4e33-5641-08d8c6c9a0db
x-ms-traffictypediagnostic: SA0PR04MB7323:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB7323F83D5612818D41CDBA689BB69@SA0PR04MB7323.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIkHLV/AqDxfYIQT+qo1Ox9NdI5kSLrcBMO8VofZ63WlkiHhhH/alafRbnUs2fXxuHYTVzl9of8Q7DxbZf9UtcxNc3Y99JQiyB0qk1IWKwVNDwRtuhSfrWmMkUAhwrWPnctiRv7CfwnexIN30Aec4+SdhB7JG7IxZ/oXXBomzYHu56hHjUPVjG0XpGIqH0hTSFaeU5tVvzY/PB5AYcU9loibN4gYFTp+Ir6uZMe4Ju3R0Q878Mb3o3ZJx6SvqUp0GogJWlk0BWj1lCcxtj2qzVvj0mtLF/UjNPXgcFyeZn1CGC47/VpRhFpvXg1paoPvgFaIgmgFjb8wm285QuTQpoW3VB4IskuQrC+qgMI/pvnHB20/knXhRGxfN2IZ++L9KLjZEczboyqWJKIOoVgKPe2L9kl7iHeOObU9yrnD37saQjS/A3yWdu9xzQbRzOOmaIR7KH1fPjYJey264N2Oh+oIeJSu3BPT3Ns+8VPf+e+IsEwkM1T/yPdCy3MuIwZuoO3U274BbJ1p63bCAJJ2E677Fi1PRzqXmqhWEzF59aYDS5GubQ1haiIRSu1knoMYMVuQBJ2lqfLL/oCHBHOL6jWweZbvnlN7SGK883IrVPE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(53546011)(6506007)(478600001)(186003)(8676002)(52536014)(966005)(8936002)(86362001)(7696005)(5660300002)(91956017)(76116006)(316002)(66476007)(66556008)(64756008)(66446008)(33656002)(54906003)(110136005)(83380400001)(9686003)(71200400001)(2906002)(55016002)(66946007)(6636002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RqQRUXLICff33LOr4FOXPh+RwLECvXYjczrudh6kvg1V5zenpVBvq5pl1xL8?=
 =?us-ascii?Q?htnUDPQIDqdfA80LCOaUosru7Q/D/5pJiW8zUXxZe0o0Fz6QuF5AxvLn0dh8?=
 =?us-ascii?Q?eG9xP7zw6FBSK4brZdxHc4otEyGv1hnbXbfqMn4caFkwCs5v0IAZAkWNKmSl?=
 =?us-ascii?Q?BXVDNHVo9IDrEgElJyl+bEPwvkYqkdejoW4CRqwgOil8+g47yww8mfc0yr80?=
 =?us-ascii?Q?IQq1rP50rNOFjpg5K9uodXNXxGyqrM8ZPEZ2GDBu6mnz+XpGZjaPRHYmzyaJ?=
 =?us-ascii?Q?Z6ZQdKEvUR4iCYXGqZj326swkOzfdDb3RFSQrSO7Ea+eIi3KkbVyLPaOuOsE?=
 =?us-ascii?Q?rMXCltuqiKa2EK4Z31J7w5vYLyRW9rF6MNwGEDGrFR03ts0dBVz/WtqH/Hlr?=
 =?us-ascii?Q?ZMJgOYyW9ZPvpB8ZluxD9O7o3t8if5pvojm/lFMRynS+4XZaXTdQL1fkzfR0?=
 =?us-ascii?Q?kCPj6jKMHljMOwrT7WF7+NKkb6RivvkDVnkkbX0o7LfkaJD2T1XfLBJdnigy?=
 =?us-ascii?Q?DZgwM+SjZELb0+dIUWgxWB4mfMCKYS6wlRpSfYNlxhVb4JOHuBVmsnGdxOZd?=
 =?us-ascii?Q?p3FqAKLn0N1wsnmcyHaTuLvas0E9H+pN/0hpjuU7nJDupgBIcGXf1peSkxDK?=
 =?us-ascii?Q?vKZxkvO0s2f50HwMq9nh9LFS8bgJ2iXIIR21X+iK0bquyEe/spDvxD1/FKkL?=
 =?us-ascii?Q?eWBJp3YyXNjrCVT/j+lO5pxc9dlkSrq6YUkfGV2dJ/bMI7o73pWYndzMpBR5?=
 =?us-ascii?Q?300uHeeQJTqBv+yIYKQNcN2SPMYSr9IaF1vpK56kCllk+v32CUDRIN0xjJO2?=
 =?us-ascii?Q?5CLspL/5LEGZnljkH/Kf8QC0Aj8ovRb9x8rDuKKUerCiaFf0A0FQEKodBgeP?=
 =?us-ascii?Q?WtzOPxiQshUJtfqGZduucCfy8xolbHjM9EpMBL+Nl+S8KptzgxNk6XIHo7fg?=
 =?us-ascii?Q?brBDje7FcbJlTnVzMPhgAcm6Xav9lBRD+9u6CAAPxTQMWxlb23/5X8sO6f1K?=
 =?us-ascii?Q?7IbizfzsridsWV7Qs7Ksr5MRUatFQ0eehCHVVNCB78fhNL8ZwXX24w7eYjMB?=
 =?us-ascii?Q?TzgitredY12tTujfbMDuh8MWCUGrkGKuNnGzN+F62de4rsAX87dogEnZteuH?=
 =?us-ascii?Q?0eBUJ5uD+l7+AYv7X516QAeY5OLV/9AkYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cad4f13-fb13-4e33-5641-08d8c6c9a0db
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 15:54:16.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u/BZzg+YoFsMMK8chFVXd4WYBO2r2t2j26F0gHmwDBq4plCoAz+NnsQBsVkzaUfbwy0najU2Bzcfe8fHo+NE6ckRdpRyRTdh3ZT5kSX4cos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7323
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/02/2021 16:49, Filipe Manana wrote:=0A=
> On Wed, Jan 27, 2021 at 6:48 PM Naohiro Aota <naohiro.aota@wdc.com> wrote=
:=0A=
>>=0A=
>> This is the 3/3 patch to enable tree-log on ZONED mode.=0A=
>>=0A=
>> The allocation order of nodes of "fs_info->log_root_tree" and nodes of=
=0A=
>> "root->log_root" is not the same as the writing order of them. So, the=
=0A=
>> writing causes unaligned write errors.=0A=
>>=0A=
>> This patch reorders the allocation of them by delaying allocation of the=
=0A=
>> root node of "fs_info->log_root_tree," so that the node buffers can go o=
ut=0A=
>> sequentially to devices.=0A=
>>=0A=
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/disk-io.c  |  7 -------=0A=
>>  fs/btrfs/tree-log.c | 24 ++++++++++++++++++------=0A=
>>  2 files changed, 18 insertions(+), 13 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index c3b5cfe4d928..d2b30716de84 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -1241,18 +1241,11 @@ int btrfs_init_log_root_tree(struct btrfs_trans_=
handle *trans,=0A=
>>                              struct btrfs_fs_info *fs_info)=0A=
>>  {=0A=
>>         struct btrfs_root *log_root;=0A=
>> -       int ret;=0A=
>>=0A=
>>         log_root =3D alloc_log_tree(trans, fs_info);=0A=
>>         if (IS_ERR(log_root))=0A=
>>                 return PTR_ERR(log_root);=0A=
>>=0A=
>> -       ret =3D btrfs_alloc_log_tree_node(trans, log_root);=0A=
>> -       if (ret) {=0A=
>> -               btrfs_put_root(log_root);=0A=
>> -               return ret;=0A=
>> -       }=0A=
>> -=0A=
>>         WARN_ON(fs_info->log_root_tree);=0A=
>>         fs_info->log_root_tree =3D log_root;=0A=
>>         return 0;=0A=
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c=0A=
>> index 71a1c0b5bc26..d8315363dc1e 100644=0A=
>> --- a/fs/btrfs/tree-log.c=0A=
>> +++ b/fs/btrfs/tree-log.c=0A=
>> @@ -3159,6 +3159,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *tra=
ns,=0A=
>>         list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index=
2]);=0A=
>>         root_log_ctx.log_transid =3D log_root_tree->log_transid;=0A=
>>=0A=
>> +       mutex_lock(&fs_info->tree_log_mutex);=0A=
>> +       if (!log_root_tree->node) {=0A=
>> +               ret =3D btrfs_alloc_log_tree_node(trans, log_root_tree);=
=0A=
>> +               if (ret) {=0A=
>> +                       mutex_unlock(&fs_info->tree_log_mutex);=0A=
>> +                       goto out;=0A=
>> +               }=0A=
>> +       }=0A=
>> +       mutex_unlock(&fs_info->tree_log_mutex);=0A=
> =0A=
> Hum, so this now has an impact for non-zoned mode.=0A=
> =0A=
> It reduces the parallelism between a previous transaction finishing=0A=
> its commit and an fsync started in the current transaction.=0A=
> =0A=
> A transaction commit releases fs_info->tree_log_mutex after it commits=0A=
> the super block.=0A=
> =0A=
> By taking that mutex here, we wait for the transaction commit to write=0A=
> the super blocks before we update the log root, start writeback of log=0A=
> tree nodes and wait for the writeback to complete.=0A=
> =0A=
> Before this change, we would do those 3 things before waiting for the=0A=
> previous transaction to commit the super blocks.=0A=
> =0A=
> So this undoes part of what was made by the following commit:=0A=
> =0A=
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D47876f7ceffa0e6af7476e052b3c061f1f2c1d9f=0A=
> =0A=
> Which landed in 5.10. This patch and the rest of the patchset was=0A=
> based on pre 5.10 code - was this missed because of that?=0A=
> Or is there some other reason to have to do things this way for non-zoned=
 mode?=0A=
> =0A=
> I think we should preserve the behaviour for non-zoned mode - i.e. any=0A=
> reason why not allocating log_root_tree->node at the top of start=0A=
> log_trans(), while under the protection of tree_root->log_mutex?=0A=
> =0A=
> My impression is that this, and the other patch with the subject=0A=
> "btrfs: serialize log transaction on ZONED mode", are out of sync with=0A=
> the changes in 5.10.=0A=
> =0A=
> Thanks, sorry for the late review.=0A=
=0A=
Yes this code has been under development for quite some time and we probabl=
y =0A=
missed this upstream update.=0A=
=0A=
We will be sending a fix ASAP.=0A=
