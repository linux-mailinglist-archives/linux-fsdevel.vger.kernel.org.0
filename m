Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21E52CDB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbiESH6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiESH5c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:57:32 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461B37BDF;
        Thu, 19 May 2022 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652947049; x=1684483049;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EMmKiaMHQtZU6T7/b0KXc7rwRJPq6mcPbPrMRQWhUk0=;
  b=jt8V87GFloC4Pm3WHF+vPfHo6hJfE9Z/b6+Jag5+87imEzyHsSQKn+YJ
   0kFHhIE8AE1MK5KDUq3SJGtDZnvRPgmpKT2UBYBdJ6eXaaHxjXYIjd5mN
   ypycHYtL4Ct6Y8QacO9EdlobwMZPeUNfsWpbmrYQD/qb5BRDDkg45qkYu
   8gNVYn74uwVg6bkJbnUBcDKTinvN2tt5XbcpsrZeDSggvzzADvll0wNMG
   JRg9jQqO91qOeReBJBjAaq3LCQsN+AgwqXMXX7hiyEEF7ILNNC3AvBdaf
   vhPpOEWlnQRSgv2GHNDxjZ4qXtrL9fb1CJLOcjL8peYjb+7ZfpFSxXbUA
   A==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647273600"; 
   d="scan'208";a="312747372"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 15:57:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjwzPzxZYKOg5xI2GMjsy6DuW290Fmwjq0tzNiuZh0x9FN+JGIBJuHRwX1rESJum6eMube5Xr6yDO3WQLC0uaNGSt/s17Qs+WwXE0ucsBcqM0QveB6QG7PcutEeAEFPhIpItLk5uwk0ybwZdSHaQ7tLWEUEbijZxq80yPDgakk0Ms59T9BGg2tuk1Zbxf1m0ZWzWpaKhjt/U+LhmLbfmqhTf6w7ge1t28HsF/tZG1ab87wNLjd1qudHn9b2Yjg03sdU5pyXUAxCX4KVgFh7cobvFH5QJ+5IYS+0/gfQQ98UOQuud0vsE4SGbPEN7eRHadKFEf4hc4twZT69j0M1wlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFVv4X1vIs1w+UGq7EY5+2E4CSibjKXudiF8EhIPIlY=;
 b=f0d5HL3pNCa2h/lLar789cgXZ1ZPkyPD9vm+JNWHrZMoK/OJl45JAIMwk7TnX+UwcEd8GSOTPtHu9e7+coL+/unA5Hr2DNzNz5LewD04moYIywR2BuylRXP2kPAiK0beTDTJW8yQ3h//KUtb6wu7Aw9LSy+sPv1QL9vzkHQ14x2/LtA4zqGByYPh2bklGahltCZXeuaVUMG0MGPucwAVARnXhLp5WRI37MnmiH0VkJCVjSpZnEqEX8wXXSMiODCnQ4riFEKkbmc+09u+qxVir60ScY2cAzNOrEB2KYxiglZmM3zAXm4Cgve9nD7nOzuB0B+A76H502qJYltdtPO6IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFVv4X1vIs1w+UGq7EY5+2E4CSibjKXudiF8EhIPIlY=;
 b=qau7xvaFzHv7ovvg0/M2rvoMH87qAMW7H1mqkjWVtTSkM6i5+HjAPir39Y1RS4iOnJp4blkiVCPGuSq1jxFS9Yxnx2GIJ3dIs4NOVFaljLlQHb/7WSOSts611VY6G9vmmBXT5aN5q+QNZSctJouxMstisqAX97zpHfIb3fnahKw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB1180.namprd04.prod.outlook.com (2603:10b6:3:a8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.13; Thu, 19 May 2022 07:57:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%4]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 07:57:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices align
 with sb log offsets
Thread-Topic: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices
 align with sb log offsets
Thread-Index: AQHYaUWvGG/TZMkJWESbmBi0yiTiyA==
Date:   Thu, 19 May 2022 07:57:26 +0000
Message-ID: <PH0PR04MB7416FF84CE207FEC3ED8912F9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
 <20220516165416.171196-9-p.raghav@samsung.com>
 <20220517124257.GD18596@twin.jikos.cz>
 <717a2c83-0678-9310-4c75-9ad5da0472f6@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0f9f08f-566c-44b4-e64f-08da396d36ff
x-ms-traffictypediagnostic: DM5PR04MB1180:EE_
x-microsoft-antispam-prvs: <DM5PR04MB1180EEFE018F11138C5A7FF19BD09@DM5PR04MB1180.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: waNJ/8nPr2Kwm7owvHFmTFigUuubmVSdf5TFO51Lx38kyphLIPpgqVUTMHAIjrA66sNy7lS56x2cnugpfmNVwbGsrWpBUT+xdJWBubI9LHUBmAFRpqfvsVJ61bGW+Vi6cXnGbZf9g8izhf20m5L7/NaKWil7hDTNvtUi18WZf+6+5eNXnwlN4P8zNu5jSNyob3LSRqH4AxqCRVXemuGEGK7rBaeDAwvSUGHXPXFNBMvI7d5zam5oGmEUESouFhT4F0X5BY7zN7sQwKWBVdIOF0uWLuRZb3AbRg+lN3nyqqy36FkVaZQC9KX6MY71J2mxMtDlS9GGdAiQ90CsS+xUrFyN4HxIIuz5zBQ4GcZyMgCDl3ksRR9NoJAOYIQbGFfzlvQqmT75ZIHubnKBUHroU2YGhEU9H01/rA4bDGovhyf1PmeZve4Z3vZiilw+fUOmdt0ssP6443j+ZMgJRMcHM3VlyHZEUPuyGk/yPoENugynyktjbPEZlUCRfb6og7G+JEFzAkMXgeujZmC2zDX6WdPRX1lHHwHhKQbgyTX1kKbwemzfSQjBX+/FK/iPdSKDE8UWoFo+gEJC3xWHetoxrqClv8jWpo1oV9XjvD0NzIE/r3aIH+zgEdAXOfQDNSFnxESovTxNm2H0qB+gzSjKrmJfcr0rMmLHx9l/97g7Q68sia0REWp+jxg/DMB9i+e77Rjvzi+vDrt/5IBU/7h8XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66446008)(4326008)(33656002)(6506007)(8676002)(7416002)(316002)(86362001)(110136005)(2906002)(7696005)(5660300002)(9686003)(122000001)(54906003)(64756008)(186003)(66476007)(66946007)(53546011)(38100700002)(82960400001)(71200400001)(55016003)(508600001)(38070700005)(76116006)(8936002)(91956017)(83380400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?reqlWfoca+h8Q2F/lukhGj4Ck/Yz8Js3BU7SLX2ytFDdzU+/uzUsiNyGgQPF?=
 =?us-ascii?Q?yx/3GT3fr91n8Dx+EoiS6zB81tgXilI+pQcxekXoEmDjMbgEIVDoU1eV8jVw?=
 =?us-ascii?Q?woFPMMJ2C2/O4GTN2Em6UF/2O2MtlMczj0UyVPb9TYUvWIlxCVPbvNP2R7+s?=
 =?us-ascii?Q?RFrHombrwDOOmIkP6acCpmNajmFLvqBzSPVUnWCKvJuJ2Dr272XPP5f9iSZe?=
 =?us-ascii?Q?ekf0AvOkPBleFoEJ9PacujeX4oB3TBzhfrUdfseQXT3AHmhDnFYRbRwulQs1?=
 =?us-ascii?Q?pIJwn1H56gS7VixIIdAuMxYMRox6hoNhlLi4sWC8j2vowwDFkRVigvyAdJkN?=
 =?us-ascii?Q?Rm6bGJ+duzFhpXWXL45/b7mYPb9K3YLw3gDNl/CIINnuEUyKOVq6YE0XkIja?=
 =?us-ascii?Q?y6sNtiJwir1B8tP9Swm9bybIWPVKk+/4/53HpGo6qnwFLTO7JgSt1iek7J6a?=
 =?us-ascii?Q?kWKFRxCGeqEed18ehjd1efrE5bV7J9nP+uGbbVdPetVJZoIs3bSSiH+IbBJC?=
 =?us-ascii?Q?LCSGZrhnsFckvHEST/zBhMeaZ93slrEDZSU5gMSDUnyeL91lH0AaisNpGXRR?=
 =?us-ascii?Q?ffzaH2yRSz6BsnsQO+xxwBHi+vg5sbjKti4SQps8JhVBymuGUVGTydIjiqfI?=
 =?us-ascii?Q?RPAGP8bGy5w/o4JoigKiNxc6dX8+EXoUgrklQ9sQFMA2uawXImpvE6deq7Tw?=
 =?us-ascii?Q?R3EkrQ7YvPK+ZcZ5L/eMgeTjJG1b+ISKG2UQ6J12oUFko9qPX6JwZ+PuM4g7?=
 =?us-ascii?Q?JURDIqgWrE+2tD0cwRXBdSeCtwqUC1prpplHgvODjwmnlCjjhbR0aXAfVRv1?=
 =?us-ascii?Q?tUeB4/IlR7ucYRip5Cb2oa9x1969x9+tYZHNk6jaRlr0vqNf1s0OOaELbDx2?=
 =?us-ascii?Q?3g3klBiIzboW+vu4SAgZWcXEB+15L/D8kRs/Pkoerz4d4NcQ8wI3XY+ovXfZ?=
 =?us-ascii?Q?Sc5t9z5aJzJOKUKdzA6+l0R1FIvpXQYrMG5h7uJLk11Ic4152s/DZv7B14p4?=
 =?us-ascii?Q?CtOPFWkU3NvQlUIG3OVYrWvWi4X7zg1MvZaBkVxGzn+WBZ3WZrLOh54r1XDr?=
 =?us-ascii?Q?8a7yrzrX01GjZk6TRV9rOPXb6wgttm+vauWnCl6rScIiJZ05pxuArHyP37T2?=
 =?us-ascii?Q?HKzm9404suMITCHPgDucHg3lEDOejZN+rZjSdehPAMxvXi2mrxVYG357zooT?=
 =?us-ascii?Q?qlzpqYJSw+fSEUz+Umtxpr8kmF+G/zeLbErtlwo6xkxJzFAz3B6TnOH//pbQ?=
 =?us-ascii?Q?V4v1lRwywKedAuVs33gEAuvN6inmQWqSlP9wA+P4OQvhKPFNVPz1w1FWY/U8?=
 =?us-ascii?Q?PfIbOYwYoszzheLFbVPEs+RdZtAKVLbcOJY1N9OY0Hc4OKiBwCm0Ka/4mb/+?=
 =?us-ascii?Q?YmS9kRwCsRTIAWZaI2a9/9x/LrEEVToEuTaHpt+iKAdWJ/H1aRQSmpzzf2sB?=
 =?us-ascii?Q?RxjX3JxzGoA7PDztKQzjfY5wC/dMA0GT5WvNsW1IYdXAmCKi6O6egEi8d3B9?=
 =?us-ascii?Q?FAI5FXKPL375ulR/NyTvaMoUhr/cmJObpE3SwBhTDNvfhgPB54kts82++bQQ?=
 =?us-ascii?Q?tkgoXf5kS4ceyk1XfyTuvqxxAaNPaBXMJjWj5D6fYNdSgTbxyb5xN4moX8Da?=
 =?us-ascii?Q?MuNGytFNI5xtc4LodDHsNmLrg66RsVQZb9i+K57786C6+8sbsGXfhsPzGvX8?=
 =?us-ascii?Q?1LDlUmYHCcTGAlEGDVByEtgNE+pTIpl7cbJXaDy/An4t5IWqPHZEvilVHjVQ?=
 =?us-ascii?Q?7glNvQ07L9zaL+hoiZ5NclsPa+ef2GqZkqWu7fsZ/ZG9f6lU1geMCCJglJ0I?=
x-ms-exchange-antispam-messagedata-1: 3wsxfGTRpd/w+lvCmDa3nDbyOTPqNmmciagjxHpKh/Em1Yr+pJQW/DTm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f9f08f-566c-44b4-e64f-08da396d36ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 07:57:26.2992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWi1xnPp4MWOwR1HYrUoogbJUyQeffPr2QXBLcBSQyB2KDZKvq9YJCxalE84HKbdS49onoWEZujnoAyzM0QM3ZTsHlRJIRy/1txiHFChlGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1180
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/05/2022 11:17, Pankaj Raghav wrote:=0A=
> On 2022-05-17 14:42, David Sterba wrote:=0A=
>> On Mon, May 16, 2022 at 06:54:11PM +0200, Pankaj Raghav wrote:=0A=
>>> Superblocks for zoned devices are fixed as 2 zones at 0, 512GB and 4TB.=
=0A=
>>> These are fixed at these locations so that recovery tools can reliably=
=0A=
>>> retrieve the superblocks even if one of the mirror gets corrupted.=0A=
>>>=0A=
>>> power of 2 zone sizes align at these offsets irrespective of their=0A=
>>> value but non power of 2 zone sizes will not align.=0A=
>>>=0A=
>>> To make sure the first zone at mirror 1 and mirror 2 align, write zero=
=0A=
>>> operation is performed to move the write pointer of the first zone to=
=0A=
>>> the expected offset. This operation is performed only after a zone rese=
t=0A=
>>> of the first zone, i.e., when the second zone that contains the sb is F=
ULL.=0A=
>> Is it a good idea to do the "write zeros", instead of a plain "set write=
=0A=
>> pointer"? I assume setting write pointer is instant, while writing=0A=
>> potentially hundreds of megabytes may take significiant time. As the=0A=
>> functions may be called from random contexts, the increased time may=0A=
>> become a problem.=0A=
>>=0A=
> Unfortunately it is not possible to just move the WP in zoned devices.=0A=
> The only alternative that I could use is to do write zeroes which are=0A=
> natively supported by some devices such as ZNS. It would be nice to know=
=0A=
> if someone had a better solution to this instead of doing write zeroes=0A=
> in zoned devices.=0A=
> =0A=
=0A=
I have another question. In case we need to pad the sb zone with a write=0A=
zeros and have a power fail between the write-zeros and the regular =0A=
super-block write, what happens? I know this padding is only done for the=
=0A=
backup super blocks, never the less it can happen and it can happen when=0A=
the primary super block is also corrupted.=0A=
=0A=
AFAIU we're then trying to reach out for a backup super block, look at the=
=0A=
write pointer and it only contains zeros but no super block, as only the =
=0A=
write-zeros has reached the device and not the super block write.=0A=
=0A=
How is this situation handled?=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
