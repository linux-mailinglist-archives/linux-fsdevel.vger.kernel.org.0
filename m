Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F106CF5CEC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2019 03:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfKICJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 21:09:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48699 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfKICJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 21:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573265345; x=1604801345;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nwE/CebU9rln5xFnMfbIvRD0clhJ/kbST3WFYw00YyA=;
  b=ChD4Kj84ZR/IT1fbg8+wPKdQbMGGGcNZRmNQgFMkS8pCzPcI0x2PP3uY
   ShyqmUp4fhcyQthy1FI0iDEANThZ8fi6/iVAt6rvvpzPrUCMR1/SmWZZN
   /l/L7uv67DGWbeudk1SZWjmYUM0+b8vY7Q4q/UsjUTI2Q09k1Vini7H6f
   J1Z9zwkMbObURc6x1y0LilrZVq0U49XvorSH1Tc5jR9lLEIvbjQTMWnUq
   Qkg6n9faIecbeZbgdKbO+YZBqV2larONCPuGN3ZvUkvvJHNG2GkQjDeAc
   HglGN0H8fKD06vx0MIwOqU0AXR+j4CntJDSPgfJqixD9wmVjg+n/ITUpO
   Q==;
IronPort-SDR: wqeJz0bW0fwyWv9kX0l7j8Q26AVimplIZhsBPW7UqkDSQOLtTDSRzshG/p+/5o7Eveo9aswQ8X
 345kn9OdudJ4FGYVDLAFigQNMUbmhG58Wony+oR4ECQgTdqMA0jMjh9tWRtOMWzOlSb6uIxgd8
 DTcv2Xe3bblkPF+QqOl8sKScsjPrLi1E4gFOHlakCbQJXzTliHuwZEIAeXEUhWohJUyk+4FXKJ
 JqbXRvZX87ywYsk7zgi6BhjfyBjSHqB7Lj7SrE//EP8TLuHxMoeErfrCOaFQl0DRFOwd7g3oz2
 1oA=
X-IronPort-AV: E=Sophos;i="5.68,283,1569254400"; 
   d="scan'208";a="126985196"
Received: from mail-bn3nam01lp2052.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.52])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2019 10:09:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2CzHmWLRly0itKnNmGXz9kz9AJxSqR7mob8IFDPIrkJFLZ61WM0McO9GOyMDwwNpu7IqaRgecB7OICJZBNf5gi1IyH5msVQeP+S83lOrr7xHbGuTBBkcUkWOLc0g3lk4rNMFU6FVcjRyAEUrwaiJJ9Tv0KMcMl3ukyISpIpOhA25yjguNd7cxmEeVHEVVddNulNBB+1jvB1YeiQ1TbizbUSxhYO8BKKHB7+9AoUklIV0yqOaJAIHIdVgZP7TAQdFXGEpaatbzVyhZhXLxZQRwhOBr9McYBhWTHI+h9QIU/7IwmE893Ebkq1tz2Z6qz2DkS/LIVepV4MdTmNmdaRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzfUH4pC78EWGttH55VBBroJmfPSB1E0MpP39A+/a0c=;
 b=ECKeRM94gZHnQmVwXvbsuLNVsXuvC1ot0PRqT8/ZsY//NHylQkTrJDbkMV7nrs8X8QmX8QwuP3qwx0UY5HRrmixY0TXphJ4oHKOvmk66U5X6opPCA18uCvDERh6Rr4s9rspRzdv8IBSH3X6NFH2WRE8wj/kN/tZcMvOmPuDoOw2JePxjY48x9ucv2lPeosQ1HptoDJa0BNKAQZuVS6nh0VgN/EeZD1I1dOmarwdn7FFr4q1HPNlrniM3mgfrNADJLEFRhmwbGPVyM3c/R2NNzoZvifVqaPImJ8VDqldLTdBJBDdlW8iiaBRUpxcITHLDOGNLZp85Udr/oN7osLyPXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzfUH4pC78EWGttH55VBBroJmfPSB1E0MpP39A+/a0c=;
 b=FRYcugBWoCL+EUPiLnCwkEJz37Jzc43OlYNZvAAbHf4bWK+kmt1Lyhr3qMui8lKYBUDZyMoSHM0I9lVi9MVYhGfsvm74yp+P50gajuWKm/8DyplzOb8NLW1bUNWyIoiEuJByu5zcrd41m85oy0eoEvKialC2tD/ikrr/I+2/Hf4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4454.namprd04.prod.outlook.com (52.135.239.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sat, 9 Nov 2019 02:09:00 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2430.023; Sat, 9 Nov 2019
 02:09:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Christie <mchristi@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin@urbackup.org" <martin@urbackup.org>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] Add prctl support for controlling mem reclaim V3
Thread-Topic: [PATCH] Add prctl support for controlling mem reclaim V3
Thread-Index: AQHVlmXVxM76pmBgckKPAmougjVLwA==
Date:   Sat, 9 Nov 2019 02:09:00 +0000
Message-ID: <BYAPR04MB5816B6F0A0448F141DE8AD54E77A0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191108185319.9326-1-mchristi@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34d70b24-c448-42d8-5981-08d764b9c949
x-ms-traffictypediagnostic: BYAPR04MB4454:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4454677284748581BBFD96AAE77A0@BYAPR04MB4454.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 021670B4D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(81156014)(81166006)(6636002)(8936002)(186003)(33656002)(99286004)(256004)(14444005)(7696005)(2501003)(76176011)(2906002)(26005)(74316002)(6116002)(3846002)(102836004)(6506007)(53546011)(8676002)(5660300002)(66066001)(316002)(71200400001)(71190400001)(110136005)(52536014)(25786009)(446003)(6436002)(6246003)(9686003)(2201001)(55016002)(86362001)(14454004)(66446008)(64756008)(66556008)(66476007)(91956017)(66946007)(76116006)(305945005)(486006)(478600001)(7736002)(229853002)(476003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4454;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JZc9WF2sHSm2KJTTgAsDjXCJSuw7Ffny2T7uM7P8zj9jmyEx57Ul2BrIQbEzUw9rgo3jEM2TZhuYat3/gJzfVKanaec6fEnkbf06xhvSPbZzEhJukWZxitVLNfmkv5jRdEYJTNZi0ldm3LUGTIdWK6kPKVQa9zYBumh8JiHLBaZxJSEum1yntnCBad8pX2MmYJuwMl91C5eBGoGEx6GOQNpmYOjDSrQMowO7rG0DwuIQTH5gT0voO71IwlfcggedB/5dY7m+EpBcX90ifJ6oBJzYtqlxaZGJvIguTjhXvkriXOtBT63F4T8PHmjNL9jNC7T8p5Z2kMbZLIuqRimNyGGL7lts8I1uKbGOpO98B/2/sfeF7yQrGGaGTtyYkdcxhZP2Mzz7Fe8areo9YLW3x7b7MOtY7b7TDZDdjB59Wuvc5m7sKoBt4rEJ3oCUWbn/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d70b24-c448-42d8-5981-08d764b9c949
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2019 02:09:00.3080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GNK6nUK02gjITJavE4j2PmYv6ymGUmtUcoSDdnFKqYgUhqxFQzgI1YzHMpYibCAXDZff9w1P9PAha1p03IpoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4454
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/11/09 3:53, Mike Christie wrote:=0A=
> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,=
=0A=
> amd nbd that have userspace components that can run in the IO path. For=
=0A=
> example, iscsi and nbd's userspace deamons may need to recreate a socket=
=0A=
> and/or send IO on it, and dm-multipath's daemon multipathd may need to=0A=
> send SG IO or read/write IO to figure out the state of paths and re-set=
=0A=
> them up.=0A=
> =0A=
> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the=0A=
> memalloc_*_save/restore functions to control the allocation behavior,=0A=
> but for userspace we would end up hitting an allocation that ended up=0A=
> writing data back to the same device we are trying to allocate for.=0A=
> The device is then in a state of deadlock, because to execute IO the=0A=
> device needs to allocate memory, but to allocate memory the memory=0A=
> layers want execute IO to the device.=0A=
> =0A=
> Here is an example with nbd using a local userspace daemon that performs=
=0A=
> network IO to a remote server. We are using XFS on top of the nbd device,=
=0A=
> but it can happen with any FS or other modules layered on top of the nbd=
=0A=
> device that can write out data to free memory.  Here a nbd daemon helper=
=0A=
> thread, msgr-worker-1, is performing a write/sendmsg on a socket to execu=
te=0A=
> a request. This kicks off a reclaim operation which results in a WRITE to=
=0A=
> the nbd device and the nbd thread calling back into the mm layer.=0A=
> =0A=
> [ 1626.609191] msgr-worker-1   D    0  1026      1 0x00004000=0A=
> [ 1626.609193] Call Trace:=0A=
> [ 1626.609195]  ? __schedule+0x29b/0x630=0A=
> [ 1626.609197]  ? wait_for_completion+0xe0/0x170=0A=
> [ 1626.609198]  schedule+0x30/0xb0=0A=
> [ 1626.609200]  schedule_timeout+0x1f6/0x2f0=0A=
> [ 1626.609202]  ? blk_finish_plug+0x21/0x2e=0A=
> [ 1626.609204]  ? _xfs_buf_ioapply+0x2e6/0x410=0A=
> [ 1626.609206]  ? wait_for_completion+0xe0/0x170=0A=
> [ 1626.609208]  wait_for_completion+0x108/0x170=0A=
> [ 1626.609210]  ? wake_up_q+0x70/0x70=0A=
> [ 1626.609212]  ? __xfs_buf_submit+0x12e/0x250=0A=
> [ 1626.609214]  ? xfs_bwrite+0x25/0x60=0A=
> [ 1626.609215]  xfs_buf_iowait+0x22/0xf0=0A=
> [ 1626.609218]  __xfs_buf_submit+0x12e/0x250=0A=
> [ 1626.609220]  xfs_bwrite+0x25/0x60=0A=
> [ 1626.609222]  xfs_reclaim_inode+0x2e8/0x310=0A=
> [ 1626.609224]  xfs_reclaim_inodes_ag+0x1b6/0x300=0A=
> [ 1626.609227]  xfs_reclaim_inodes_nr+0x31/0x40=0A=
> [ 1626.609228]  super_cache_scan+0x152/0x1a0=0A=
> [ 1626.609231]  do_shrink_slab+0x12c/0x2d0=0A=
> [ 1626.609233]  shrink_slab+0x9c/0x2a0=0A=
> [ 1626.609235]  shrink_node+0xd7/0x470=0A=
> [ 1626.609237]  do_try_to_free_pages+0xbf/0x380=0A=
> [ 1626.609240]  try_to_free_pages+0xd9/0x1f0=0A=
> [ 1626.609245]  __alloc_pages_slowpath+0x3a4/0xd30=0A=
> [ 1626.609251]  ? ___slab_alloc+0x238/0x560=0A=
> [ 1626.609254]  __alloc_pages_nodemask+0x30c/0x350=0A=
> [ 1626.609259]  skb_page_frag_refill+0x97/0xd0=0A=
> [ 1626.609274]  sk_page_frag_refill+0x1d/0x80=0A=
> [ 1626.609279]  tcp_sendmsg_locked+0x2bb/0xdd0=0A=
> [ 1626.609304]  tcp_sendmsg+0x27/0x40=0A=
> [ 1626.609307]  sock_sendmsg+0x54/0x60=0A=
> [ 1626.609308]  ___sys_sendmsg+0x29f/0x320=0A=
> [ 1626.609313]  ? sock_poll+0x66/0xb0=0A=
> [ 1626.609318]  ? ep_item_poll.isra.15+0x40/0xc0=0A=
> [ 1626.609320]  ? ep_send_events_proc+0xe6/0x230=0A=
> [ 1626.609322]  ? hrtimer_try_to_cancel+0x54/0xf0=0A=
> [ 1626.609324]  ? ep_read_events_proc+0xc0/0xc0=0A=
> [ 1626.609326]  ? _raw_write_unlock_irq+0xa/0x20=0A=
> [ 1626.609327]  ? ep_scan_ready_list.constprop.19+0x218/0x230=0A=
> [ 1626.609329]  ? __hrtimer_init+0xb0/0xb0=0A=
> [ 1626.609331]  ? _raw_spin_unlock_irq+0xa/0x20=0A=
> [ 1626.609334]  ? ep_poll+0x26c/0x4a0=0A=
> [ 1626.609337]  ? tcp_tsq_write.part.54+0xa0/0xa0=0A=
> [ 1626.609339]  ? release_sock+0x43/0x90=0A=
> [ 1626.609341]  ? _raw_spin_unlock_bh+0xa/0x20=0A=
> [ 1626.609342]  __sys_sendmsg+0x47/0x80=0A=
> [ 1626.609347]  do_syscall_64+0x5f/0x1c0=0A=
> [ 1626.609349]  ? prepare_exit_to_usermode+0x75/0xa0=0A=
> [ 1626.609351]  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
> =0A=
> This patch adds a new prctl command that daemons can use after they have=
=0A=
> done their initial setup, and before they start to do allocations that=0A=
> are in the IO path. It sets the PF_MEMALLOC_NOIO and PF_LESS_THROTTLE=0A=
> flags so both userspace block and FS threads can use it to avoid the=0A=
> allocation recursion and try to prevent from being throttled while=0A=
> writing out data to free up memory.=0A=
> =0A=
> Signed-off-by: Mike Christie <mchristi@redhat.com>=0A=
> ---=0A=
> V3 =0A=
> - Drop NOFS, set PF_LESS_THROTTLE and rename prctl flag to reflect it=0A=
> is more general and can support both FS and block devices. Both fuse=0A=
> and block device daemons, nbd and tcmu-runner, have been tested to=0A=
> confirm the more restrictive PF_MEMALLOC_NOIO also works for fuse.=0A=
> =0A=
> - Use CAP_SYS_RESOURCE instead of admin.=0A=
> =0A=
> V2:=0A=
> - Use prctl instead of procfs.=0A=
> - Add support for NOFS for fuse.=0A=
> - Check permissions.=0A=
> =0A=
> =0A=
>  include/uapi/linux/capability.h |  1 +=0A=
>  include/uapi/linux/prctl.h      |  4 ++++=0A=
>  kernel/sys.c                    | 26 ++++++++++++++++++++++++++=0A=
>  3 files changed, 31 insertions(+)=0A=
> =0A=
> diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capabil=
ity.h=0A=
> index 240fdb9a60f6..272dc69fa080 100644=0A=
> --- a/include/uapi/linux/capability.h=0A=
> +++ b/include/uapi/linux/capability.h=0A=
> @@ -301,6 +301,7 @@ struct vfs_ns_cap_data {=0A=
>  /* Allow more than 64hz interrupts from the real-time clock */=0A=
>  /* Override max number of consoles on console allocation */=0A=
>  /* Override max number of keymaps */=0A=
> +/* Control memory reclaim behavior */=0A=
>  =0A=
>  #define CAP_SYS_RESOURCE     24=0A=
>  =0A=
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h=0A=
> index 7da1b37b27aa..07b4f8131e36 100644=0A=
> --- a/include/uapi/linux/prctl.h=0A=
> +++ b/include/uapi/linux/prctl.h=0A=
> @@ -234,4 +234,8 @@ struct prctl_mm_map {=0A=
>  #define PR_GET_TAGGED_ADDR_CTRL		56=0A=
>  # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)=0A=
>  =0A=
> +/* Control reclaim behavior when allocating memory */=0A=
> +#define PR_SET_IO_FLUSHER		57=0A=
> +#define PR_GET_IO_FLUSHER		58=0A=
> +=0A=
>  #endif /* _LINUX_PRCTL_H */=0A=
> diff --git a/kernel/sys.c b/kernel/sys.c=0A=
> index a611d1d58c7d..08c6b682fa99 100644=0A=
> --- a/kernel/sys.c=0A=
> +++ b/kernel/sys.c=0A=
> @@ -2486,6 +2486,32 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,=0A=
>  			return -EINVAL;=0A=
>  		error =3D GET_TAGGED_ADDR_CTRL();=0A=
>  		break;=0A=
> +	case PR_SET_IO_FLUSHER:=0A=
> +		if (!capable(CAP_SYS_RESOURCE))=0A=
> +			return -EPERM;=0A=
> +=0A=
> +		if (arg3 || arg4 || arg5)=0A=
> +			return -EINVAL;=0A=
> +=0A=
> +		if (arg2 =3D=3D 1)=0A=
> +			current->flags |=3D PF_MEMALLOC_NOIO | PF_LESS_THROTTLE;=0A=
> +		else if (!arg2)=0A=
> +			current->flags &=3D ~(PF_MEMALLOC_NOIO | PF_LESS_THROTTLE);=0A=
> +		else=0A=
> +			return -EINVAL;=0A=
> +		break;=0A=
> +	case PR_GET_IO_FLUSHER:=0A=
> +		if (!capable(CAP_SYS_RESOURCE))=0A=
> +			return -EPERM;=0A=
> +=0A=
> +		if (arg2 || arg3 || arg4 || arg5)=0A=
> +			return -EINVAL;=0A=
> +=0A=
> +		if (current->flags & (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE))=0A=
> +			error =3D 1;=0A=
> +		else=0A=
> +			error =3D 0;=0A=
> +		break;=0A=
>  	default:=0A=
>  		error =3D -EINVAL;=0A=
>  		break;=0A=
> =0A=
=0A=
Masato Suzuki in my team tested this with tcmu-runner ZBC file handler.=0A=
It solves the memory reclaim recursion deadlock that we have been=0A=
observing when this patch is used together with the one I sent yesterday=0A=
to the SCSI list (target: core: Prevent memory reclaim recursion).=0A=
=0A=
Sending tested-by tag on behalf of Masato.=0A=
=0A=
Tested-by: Masato Suzuki <masato.suzuki@wdc.com>=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
