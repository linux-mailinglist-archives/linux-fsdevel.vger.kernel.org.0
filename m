Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0ED5B672C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 07:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIMFNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 01:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIMFNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:13:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9885E43611;
        Mon, 12 Sep 2022 22:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663045992; x=1694581992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=6qVyDhUZvPUtPSUHNjCLR9x3thGk+bbQshZb/eQhYhU=;
  b=NK11IxacvOplRKpfEcGMm0P0mpnlXaK4HlXEkb9fm8rzeKLLJ7qgMaXM
   rPzJwuxCaOTyyW/bz/S1+kBUygInsIJG9NXIFZiUH9yd5+sc+uJixkJJW
   3lbAIX+DXrytLh7/BObWX4C86uf3AE9ElZFl29ekzPHfpf1hlkGg7VoMK
   woACnJU5WhD4acDx1dkDBvFQtBVsgjbf5FITBDrE/wqeOKhJo9o0/Bqmq
   OSPwscxaG7xwlcE1uMymsu4DMhB7mmqnAnBkPelKhDrBv7GArlJvgmE12
   ns644DatjqPIx9t3/vd+AkFAYQ/ffPGYdXxUwNK+EQ8LmI84E44jtt6w+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="281057913"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="txt'?scan'208";a="281057913"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 22:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="txt'?scan'208";a="720027829"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2022 22:13:11 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 22:13:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 12 Sep 2022 22:13:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 12 Sep 2022 22:13:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuxCiKaCcnoMXcC5MNOB+VBlpA3oQftAEqIuAMwPkBWcUxIBJCQ0isWUGN5neLLAzK4pVAKniGaZkqD3BSbqvNH63FhbFLuKT45g5wNrDuC2sUneax6kN6AHJGksagq+8rrAL7/quANqpQFuqI70zO4CygP69XcUQuq5Y41qDZSt4w5ltJnqCsOneNXw0fYYl4sm7KthMWsbGuOmH8kmW9dy4aPQdq/gsQXVIdg7PMZSdYfSIooka1v1BhkyEMLWx7l/ZzI8gO1X+TAwytQ+zeA18hbEN075JUf+jiM1vEH72H3WOQLC9ku0iE/jNGPKgnvQo53E7WvrCVO4u/KUcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDPXbkiJYjPD8/9S+Xg0BgK8gP7JZhQcKFaHJt98O+8=;
 b=V/7CR2MLuheOIRnOXYUnphadjGkMvi26gTjMZBSUD+H/YN58dJEe+8eVRK8arKYScBDixbt4Trbdzm2D3WmLvtsO0G2eUCjLP/PclHzj7kp/MJMrQ7+pEmScn0NUDsBvGKZcz6IrU4HtRL0rc1FZNYXHQE/nGxK1qc7kESze7xC4akEfvHNnmLpfvdFGiUNgwvQz//VWC3w4rZO26vBVa+jExUqqzDsAAiX6UoVEmA88J9v9+DtvNXBLJWS5WhBnB6NQilAYYCk9+baapKd9iKInclkv9hXsarzp03mMaLdjbOKp8AyJU5fGrn9PF2oKwzIqF2VLYN3jhLEvxhUPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21)
 by PH0PR11MB4789.namprd11.prod.outlook.com (2603:10b6:510:38::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Tue, 13 Sep
 2022 05:13:09 +0000
Received: from CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::b44e:f690:cbae:efc5]) by CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::b44e:f690:cbae:efc5%8]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 05:13:09 +0000
From:   "Zhou, Jie2X" <jie2x.zhou@intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "guozhengkui@vivo.com" <guozhengkui@vivo.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: make run_tests -C proc: proc-pid-vm assertion failed.
Thread-Topic: make run_tests -C proc: proc-pid-vm assertion failed.
Thread-Index: AQHYw/LNI/GNNDlqykS3LtARfPjX+q3Wj/SAgAYwym0=
Date:   Tue, 13 Sep 2022 05:13:08 +0000
Message-ID: <CY4PR11MB1320D6B4887D0EFBB6C188FAC5479@CY4PR11MB1320.namprd11.prod.outlook.com>
References: <20220909021916.43293-1-jie2x.zhou@intel.com>
 <YxrNM3q2W8BARvj5@localhost.localdomain>
In-Reply-To: <YxrNM3q2W8BARvj5@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1320:EE_|PH0PR11MB4789:EE_
x-ms-office365-filtering-correlation-id: e0fd9a4a-a1b0-4b96-0089-08da9546a5e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TCmO9s33tCCWIZxNc0rtrKGciaJSqdSObmrM9OOapRPbWIiHNnGHOQ7HB3AFzyOXFa2+rYX/9aZmC03Kp1bXt4d/Sa10Rb7N9+sAKX8mll1q9VlNBwxH3pQ6DEfDQP+/yLLcvXBaZz5EqNytjWsBlyDydo/fvlM7xbI2D0WNQpEix07Ype7nlHoVbQNuqeSUZwB6zFgX7AowOPhXNyXpN5eE8Qt0DKqbzgiKbzyqqF4tYFdZ/jZOd+3BcrdVJv2yZwzK6XKij69Cf0EBdfIMwfkDNPq5rO4e1WKAEGSOEYcx5WE3GMp7SPfNcX25LhceEh+0/PEZmQTKVSdpdNh3wES1WID+vJ+RiIszEQcJunqDoRWVyYkNUhqJUrcwuQxfh0xd4wyUDlEcxRZX5TV4Uiuw96ltM4A8nkKPrCXkAqJSVfwkw7AXnX/9eC+hF4p796ctN8ngzwUJBnjSBCQbIPRsP8B9ol3Osd5YN02WfK/HYkXLNZxGso9+5g/7YwXVpyls+Lstt/4WgaBA4j4U1xtI8hw4Q2T0++gkHoCTU4wJlrUjgb4RMEmRn668+cfhYeSEcfwSHgua5gkIbMb6tmN+/T21Sn9DhmFsyKnu6mbPALtq/EN2OJNzYKa5HTZV6gmzR6XsU59I7rWSVL3bANNOzykeKcmkQMqImFQLUT5lRN4CKqqXiVMMk42xyg/P33UOfX29SdkVq/E6hRkjo1zy69wo4372xuA93tnk5MRJMgeXgahgA/dnDAuZYwXt8UXxgT/2vqPjpvyHR0FIJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(316002)(54906003)(38070700005)(53546011)(71200400001)(186003)(33656002)(38100700002)(2906002)(66476007)(9686003)(26005)(6916009)(99936003)(52536014)(7696005)(6506007)(83380400001)(5660300002)(478600001)(8676002)(86362001)(107886003)(122000001)(66556008)(8936002)(91956017)(41300700001)(66446008)(82960400001)(66946007)(76116006)(64756008)(55016003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lOHG3KUh1avzk66TmAQUE0IRra800RhXz6zQyEFn5PawB+7rUfyhDTVPoxIJ?=
 =?us-ascii?Q?lKeKpw4ISMCgsHZ6ZCIUPo3vx5SRtxkqWE41yShoasNASPsIHNnBNr2yrSyk?=
 =?us-ascii?Q?6Vhlv/H82aZB7r8Bfyu164ys9P2Laj2yfac74IaqH7XUf71oUVLaO9CXYAfB?=
 =?us-ascii?Q?8pC5uZ1Dbtcr3KNlv+hn19D7QxJwdy14bmZnImgNmfItC1ZJtFs1/8zWMxa8?=
 =?us-ascii?Q?5OEDj+KH1uHtjTe5ZG1Cnc9YmBhi2Zn523QSU2zZyq1Hi6IlaRZBB8H0LV5A?=
 =?us-ascii?Q?Bw3/mryKFQuB2EFHIhMSTEi9MtJnbILpFeBkcv+BgQ7lyZ2x49hSyjAb1eYM?=
 =?us-ascii?Q?v+jQB7+O33BWGQvOad3VA+HFuwL2dKxLW3ACmJiXv3KD1HULrQwX2QUhqEEx?=
 =?us-ascii?Q?SN9jBrImncvh5bNA+xs6JqMLBNbp4PvqC2K1GSq3ZnsFU9vwqw+CBirfmC1R?=
 =?us-ascii?Q?j99opvqEhEQvoGghEm8rEpnXUPHsW572qdKywMH4P15BS5c3zDxvrs9TJkGw?=
 =?us-ascii?Q?zYpkIjhtA8rttdIiuqS9BnE28eFQmM8G0i0Jn+qrHkeRqYT3CQeTTo6ahHs1?=
 =?us-ascii?Q?qb19lqzbRHlzhkc7ij7rz797ezHjqY3TzNpoDOwY9iWKz9VZEqz6BA4MplSk?=
 =?us-ascii?Q?igT9hdw4baEh1m+ErOabc1A/WUobeOrAH37EMjpAXWqrzfV2QPXNmY2jjnjo?=
 =?us-ascii?Q?fjjLkQcqayFGvVSr0PTAq23KAjKsUsAbbxmS2lBoABoMNmgF+KolYSXPeU67?=
 =?us-ascii?Q?FInfmkEbqkkq43bvbDjt4OnsWZ5PfTMttko40GZeic8OA9zc6P6SbNUi9SQp?=
 =?us-ascii?Q?tlLxr4NDGO0C/UseZkdlF6M4SnCLeFBQbNd1q5OaFHUTX6ecE2RuBUfTANoe?=
 =?us-ascii?Q?3oxpE394ddpO1z0GBJp3cuK3FAz2M/qfqKjghJoEekt1Pz/oVl/AUuVRR9uU?=
 =?us-ascii?Q?xODDqY5hXY6Qf8LlutTiTs20UJZQaYlgVLM54vqh+5025FryUuWV39PBa3jP?=
 =?us-ascii?Q?CrRZujxGyilMVmXRGFys8eXz+USxXVNKEPRgvkVv3iAwpiU1LX41Vq35mK9O?=
 =?us-ascii?Q?MbNu2/qekb62YazYyzwvWjg8Jdmnmtrnkuk9IxoQ4HhpdxmMg7VGw158v8fm?=
 =?us-ascii?Q?VGAZh+Vi2sfQylHXaeUOWCp6N9BeiU0J6nZsaWKh/Rx/SDgd2/QKNt93VaTS?=
 =?us-ascii?Q?BR67oLFYWdQVUFQYiKQKcHKev+gtBM3OItfYh91wS6qor7NneVXejIzwIl1m?=
 =?us-ascii?Q?n3FVOgHgc1MjjEJ8T86V/YEBmx9wqSJVS/4tySOMFYXXSiCkLDKySpGO/uDa?=
 =?us-ascii?Q?7V+TCrhTHZ7QsExE6aXf4I33aEOLyH873F/GsZ9dQPFbAdK+oLlYyPRyrLEb?=
 =?us-ascii?Q?Y3xWXdXh75GGDID+anyOcNSaB7bhbji2HyeC7aMohu5jvv1KPlSxC5MUhALt?=
 =?us-ascii?Q?tz6+9aq/X0UXCNGCA916/Ddwy7tJYsYxb/FKPj9Bag3FkSvBqXa5/EuhOLkH?=
 =?us-ascii?Q?KCR/fzX95w3nFEk7FCFlnN2C35UFRa95pRqW9pqeptsK7GKwWP+rwhlKIVnK?=
 =?us-ascii?Q?iopOszGlxlysFh8MMHMIXgfgWe6CXN3PD/CxFFnF?=
Content-Type: multipart/mixed;
        boundary="_002_CY4PR11MB1320D6B4887D0EFBB6C188FAC5479CY4PR11MB1320namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fd9a4a-a1b0-4b96-0089-08da9546a5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 05:13:08.9022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U99qeTcb5BRpfnkuEKgL/9CdldRsQe19J9qVoe1DY49X5SkmEDPXdS9l9m1hz26JmR3fkgwPPO5eAV6eyMKvdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_CY4PR11MB1320D6B4887D0EFBB6C188FAC5479CY4PR11MB1320namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi,

>Can't reproduce. Please, post "strace -f ./proc-pid-vm".
test in "Debian GNU/Linux bookworm/sid"
And the strace output is attached.

best regards,

________________________________________
From: Alexey Dobriyan <adobriyan@gmail.com>
Sent: Friday, September 9, 2022 1:20 PM
To: Zhou, Jie2X
Cc: shuah@kernel.org; guozhengkui@vivo.com; akpm@linux-foundation.org; linu=
x-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-kselftest@vg=
er.kernel.org; Li, Philip
Subject: Re: make run_tests -C proc: proc-pid-vm assertion failed.

On Fri, Sep 09, 2022 at 10:19:16AM +0800, Jie2x Zhou wrote:
> hi,
>
> The test error is caused by g_vsyscall set failed.


> Error output:
>  selftests: proc: proc-pid-vm
>  proc-pid-vm: proc-pid-vm.c:389: main: Assertion `rv =3D=3D len' failed.
>  Aborted
>
> g_vsyscall is set to 0.
> In proc-pid-vm.c:
> /*
>  * 0: vsyscall VMA doesn't exist        vsyscall=3Dnone
>  * 1: vsyscall VMA is r-xp              vsyscall=3Demulate
>  * 2: vsyscall VMA is --xp              vsyscall=3Dxonly
>  */
> static int g_vsyscall;
> static const char *str_vsyscall;
>
> static const char str_vsyscall_0[] =3D "";
> static const char str_vsyscall_1[] =3D
> "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                 =
 [vsyscall]\n";
> static const char str_vsyscall_2[] =3D
> "ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                 =
 [vsyscall]\n";
>
> The /proc/%u/maps output is:
> buf=3D100000000-100001000 r-xp 00000000 00:2d 2                          =
      /tmp/#2 (deleted)
> ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  =
[vsyscall]
>
> So the g_vsyscall should be 2 according to commentary(2: vsyscall VMA is =
--xp).
> Is it a bug?

Can't reproduce. Please, post "strace -f ./proc-pid-vm".

--_002_CY4PR11MB1320D6B4887D0EFBB6C188FAC5479CY4PR11MB1320namp_
Content-Type: text/plain; name="proc-pid-vm.strace.txt"
Content-Description: proc-pid-vm.strace.txt
Content-Disposition: attachment; filename="proc-pid-vm.strace.txt"; size=5554;
	creation-date="Tue, 13 Sep 2022 05:11:26 GMT";
	modification-date="Tue, 13 Sep 2022 05:11:26 GMT"
Content-Transfer-Encoding: base64

ZXhlY3ZlKCIuL3Byb2MtcGlkLXZtIiwgWyIuL3Byb2MtcGlkLXZtIl0sIDB4N2ZmZTVhZWUwOGM4
IC8qIDExMSB2YXJzICovKSA9IDAKYnJrKE5VTEwpICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgID0gMHg1NWNhZmNmMzUwMDAKbW1hcChOVUxMLCA4MTkyLCBQUk9UX1JFQUR8UFJPVF9XUklU
RSwgTUFQX1BSSVZBVEV8TUFQX0FOT05ZTU9VUywgLTEsIDApID0gMHg3ZjQ4ZDc5YzMwMDAKYWNj
ZXNzKCIvZXRjL2xkLnNvLnByZWxvYWQiLCBSX09LKSAgICAgID0gLTEgRU5PRU5UIChObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5KQpvcGVuYXQoQVRfRkRDV0QsICIvZXRjL2xkLnNvLmNhY2hlIiwg
T19SRE9OTFl8T19DTE9FWEVDKSA9IDMKbmV3ZnN0YXRhdCgzLCAiIiwge3N0X21vZGU9U19JRlJF
R3wwNjQ0LCBzdF9zaXplPTI5Mjk1LCAuLi59LCBBVF9FTVBUWV9QQVRIKSA9IDAKbW1hcChOVUxM
LCAyOTI5NSwgUFJPVF9SRUFELCBNQVBfUFJJVkFURSwgMywgMCkgPSAweDdmNDhkNzliYjAwMApj
bG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCm9wZW5hdChBVF9GRENX
RCwgIi9saWIveDg2XzY0LWxpbnV4LWdudS9saWJjLnNvLjYiLCBPX1JET05MWXxPX0NMT0VYRUMp
ID0gMwpyZWFkKDMsICJcMTc3RUxGXDJcMVwxXDNcMFwwXDBcMFwwXDBcMFwwXDNcMD5cMFwxXDBc
MFwwXDMwMFwyMjNcMlwwXDBcMFwwXDAiLi4uLCA4MzIpID0gODMyCnByZWFkNjQoMywgIlw2XDBc
MFwwXDRcMFwwXDBAXDBcMFwwXDBcMFwwXDBAXDBcMFwwXDBcMFwwXDBAXDBcMFwwXDBcMFwwXDAi
Li4uLCA3ODQsIDY0KSA9IDc4NApwcmVhZDY0KDMsICJcNFwwXDBcMFwyMFwwXDBcMFw1XDBcMFww
R05VXDBcMlwyMDBcMFwzMDBcNFwwXDBcMFwxXDBcMFwwXDBcMFwwXDAiLCAzMiwgODQ4KSA9IDMy
CnByZWFkNjQoMywgIlw0XDBcMFwwXDI0XDBcMFwwXDNcMFwwXDBHTlVcMFwzMzV+N2FcMjMxXDMz
M1wzMDdcMjU2XDIwN1wyNjclRlwyNzFcMzRcMjY3XDIxMSIuLi4sIDY4LCA4ODApID0gNjgKbmV3
ZnN0YXRhdCgzLCAiIiwge3N0X21vZGU9U19JRlJFR3wwNzU1LCBzdF9zaXplPTIwNDkwMzIsIC4u
Ln0sIEFUX0VNUFRZX1BBVEgpID0gMApwcmVhZDY0KDMsICJcNlwwXDBcMFw0XDBcMFwwQFwwXDBc
MFwwXDBcMFwwQFwwXDBcMFwwXDBcMFwwQFwwXDBcMFwwXDBcMFwwIi4uLiwgNzg0LCA2NCkgPSA3
ODQKbW1hcChOVUxMLCAyMTAxMTM2LCBQUk9UX1JFQUQsIE1BUF9QUklWQVRFfE1BUF9ERU5ZV1JJ
VEUsIDMsIDApID0gMHg3ZjQ4ZDc3YmEwMDAKbW1hcCgweDdmNDhkNzdlMjAwMCwgMTQ5OTEzNiwg
UFJPVF9SRUFEfFBST1RfRVhFQywgTUFQX1BSSVZBVEV8TUFQX0ZJWEVEfE1BUF9ERU5ZV1JJVEUs
IDMsIDB4MjgwMDApID0gMHg3ZjQ4ZDc3ZTIwMDAKbW1hcCgweDdmNDhkNzk1MDAwMCwgMzYwNDQ4
LCBQUk9UX1JFQUQsIE1BUF9QUklWQVRFfE1BUF9GSVhFRHxNQVBfREVOWVdSSVRFLCAzLCAweDE5
NjAwMCkgPSAweDdmNDhkNzk1MDAwMAptbWFwKDB4N2Y0OGQ3OWE4MDAwLCAyNDU3NiwgUFJPVF9S
RUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRHxNQVBfREVOWVdSSVRFLCAzLCAw
eDFlZDAwMCkgPSAweDdmNDhkNzlhODAwMAptbWFwKDB4N2Y0OGQ3OWFlMDAwLCA1MzEzNiwgUFJP
VF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFfE1BUF9GSVhFRHxNQVBfQU5PTllNT1VTLCAt
MSwgMCkgPSAweDdmNDhkNzlhZTAwMApjbG9zZSgzKSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgPSAwCm1tYXAoTlVMTCwgMTIyODgsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJ
VkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCkgPSAweDdmNDhkNzdiNzAwMAphcmNoX3ByY3RsKEFS
Q0hfU0VUX0ZTLCAweDdmNDhkNzdiNzc0MCkgPSAwCnNldF90aWRfYWRkcmVzcygweDdmNDhkNzdi
N2ExMCkgICAgICAgICA9IDEwNjc4CnNldF9yb2J1c3RfbGlzdCgweDdmNDhkNzdiN2EyMCwgMjQp
ICAgICA9IDAKbXByb3RlY3QoMHg3ZjQ4ZDc5YTgwMDAsIDE2Mzg0LCBQUk9UX1JFQUQpID0gMApt
cHJvdGVjdCgweDU1Y2FmYzcwYTAwMCwgNDA5NiwgUFJPVF9SRUFEKSA9IDAKbXByb3RlY3QoMHg3
ZjQ4ZDc5ZjUwMDAsIDgxOTIsIFBST1RfUkVBRCkgPSAwCnBybGltaXQ2NCgwLCBSTElNSVRfU1RB
Q0ssIE5VTEwsIHtybGltX2N1cj04MTkyKjEwMjQsIHJsaW1fbWF4PVJMSU02NF9JTkZJTklUWX0p
ID0gMAptdW5tYXAoMHg3ZjQ4ZDc5YmIwMDAsIDI5Mjk1KSAgICAgICAgICAgPSAwCmNsb25lKGNo
aWxkX3N0YWNrPU5VTEwsIGZsYWdzPUNMT05FX0NISUxEX0NMRUFSVElEfENMT05FX0NISUxEX1NF
VFRJRHxTSUdDSExELCBjaGlsZF90aWRwdHI9MHg3ZjQ4ZDc3YjdhMTApID0gMTA2NzkKc3RyYWNl
OiBQcm9jZXNzIDEwNjc5IGF0dGFjaGVkCltwaWQgMTA2NzhdIHdhaXQ0KDEwNjc5LCAgPHVuZmlu
aXNoZWQgLi4uPgpbcGlkIDEwNjc5XSBzZXRfcm9idXN0X2xpc3QoMHg3ZjQ4ZDc3YjdhMjAsIDI0
KSA9IDAKW3BpZCAxMDY3OV0gcHJsaW1pdDY0KDAsIFJMSU1JVF9DT1JFLCB7cmxpbV9jdXI9MCwg
cmxpbV9tYXg9MH0sIE5VTEwpID0gMApbcGlkIDEwNjc5XSBydF9zaWdhY3Rpb24oU0lHU0VHViwg
e3NhX2hhbmRsZXI9MHg1NWNhZmM3MDgwODAsIHNhX21hc2s9W10sIHNhX2ZsYWdzPVNBX1JFU1RP
UkVSfFNBX1NJR0lORk8sIHNhX3Jlc3RvcmVyPTB4N2Y0OGQ3N2Y3YWYwfSwgTlVMTCwgOCkgPSAw
CltwaWQgMTA2NzldIC0tLSBTSUdTRUdWIHtzaV9zaWdubz1TSUdTRUdWLCBzaV9jb2RlPVNFR1Zf
TUFQRVJSLCBzaV9hZGRyPTB4NTVjYWZiZDA2MDAwfSAtLS0KW3BpZCAxMDY3OV0gZXhpdF9ncm91
cCgxKSAgICAgICAgICAgICAgID0gPwpbcGlkIDEwNjc5XSArKysgZXhpdGVkIHdpdGggMSArKysK
PC4uLiB3YWl0NCByZXN1bWVkPlt7V0lGRVhJVEVEKHMpICYmIFdFWElUU1RBVFVTKHMpID09IDF9
XSwgMCwgTlVMTCkgPSAxMDY3OQotLS0gU0lHQ0hMRCB7c2lfc2lnbm89U0lHQ0hMRCwgc2lfY29k
ZT1DTERfRVhJVEVELCBzaV9waWQ9MTA2NzksIHNpX3VpZD0wLCBzaV9zdGF0dXM9MSwgc2lfdXRp
bWU9MCwgc2lfc3RpbWU9MH0gLS0tCnVuc2hhcmUoQ0xPTkVfTkVXTlMpICAgICAgICAgICAgICAg
ICAgICA9IDAKbW91bnQoTlVMTCwgIi8iLCBOVUxMLCBNU19SRUN8TVNfUFJJVkFURSwgTlVMTCkg
PSAwCm1vdW50KE5VTEwsICIvdG1wIiwgInRtcGZzIiwgMCwgTlVMTCkgICA9IDAKY2xvc2UoMCkg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gMApvcGVuYXQoQVRfRkRDV0QsICIvIiwg
T19SRE9OTFl8T19QQVRIfE9fRElSRUNUT1JZKSA9IDAKb3BlbmF0KEFUX0ZEQ1dELCAiL3RtcCIs
IE9fV1JPTkxZfE9fRVhDTHxPX1RNUEZJTEUsIDA3MDApID0gMwp3cml0ZXYoMywgW3tpb3ZfYmFz
ZT0iXDE3N0VMRlwyXDFcMVwwXDBcMFwwXDBcMFwwXDBcMFwyXDA+XDBcMVwwXDBcMHhcMFwwXDBc
MVwwXDBcMCIuLi4sIGlvdl9sZW49NjR9LCB7aW92X2Jhc2U9IlwxXDBcMFwwXDVcMFwwXDBcMFww
XDBcMFwwXDBcMFwwXDBcMFwwXDBcMVwwXDBcMFwwXDBcMFwwXDBcMFwwXDAiLi4uLCBpb3ZfbGVu
PTU2fSwge2lvdl9iYXNlPSJIXDI3N1wwXDIwXDBcMFwxXDBcMFwwSFwyNzZcMFwzNDBcMzc3XDM3
N1wzNzZcMTc3XDBcMFwyNzBcdlwwXDBcMFwxN1wwMDUxXDM3N0hcMjE1NSIuLi4sIGlvdl9sZW49
NTd9XSwgMykgPSAxNzcKb3BlbmF0KEFUX0ZEQ1dELCAiL3Byb2Mvc2VsZi9mZC8zIiwgT19SRE9O
TFl8T19DTE9FWEVDKSA9IDQKY2xvc2UoMykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ID0gMApwaXBlKFszLCA1XSkgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwCmR1cDIoNSwg
MCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IDAKY2xvbmUoY2hpbGRfc3RhY2s9TlVM
TCwgZmxhZ3M9Q0xPTkVfQ0hJTERfQ0xFQVJUSUR8Q0xPTkVfQ0hJTERfU0VUVElEfFNJR0NITERz
dHJhY2U6IFByb2Nlc3MgMTA2ODAgYXR0YWNoZWQKLCBjaGlsZF90aWRwdHI9MHg3ZjQ4ZDc3Yjdh
MTApID0gMTA2ODAKW3BpZCAxMDY4MF0gc2V0X3JvYnVzdF9saXN0KDB4N2Y0OGQ3N2I3YTIwLCAy
NCA8dW5maW5pc2hlZCAuLi4+CltwaWQgMTA2NzhdIHJlYWQoMywgIDx1bmZpbmlzaGVkIC4uLj4K
W3BpZCAxMDY4MF0gPC4uLiBzZXRfcm9idXN0X2xpc3QgcmVzdW1lZD4pID0gMApbcGlkIDEwNjgw
XSBleGVjdmVhdCg0LCAiIiwgTlVMTCwgTlVMTCwgQVRfRU1QVFlfUEFUSCkgPSAwCltwaWQgMTA2
ODBdIG11bm1hcCgweDEwMDAwMTAwMCwgMTQwNzMzMTkzMzc5ODQwKSA9IDAKW3BpZCAxMDY4MF0g
d3JpdGUoMCwgIlwyNzIiLCAxKSAgICAgICAgID0gMQpbcGlkIDEwNjc4XSA8Li4uIHJlYWQgcmVz
dW1lZD4iXDI3MiIsIDEpID0gMQpbcGlkIDEwNjgwXSBwYXVzZSggPHVuZmluaXNoZWQgLi4uPgpb
cGlkIDEwNjc4XSBuZXdmc3RhdGF0KDQsICIiLCB7c3RfbW9kZT1TX0lGUkVHfDA3MDAsIHN0X3Np
emU9MTc3LCAuLi59LCBBVF9FTVBUWV9QQVRIKSA9IDAKW3BpZCAxMDY3OF0gb3BlbmF0KEFUX0ZE
Q1dELCAiL3Byb2MvMTA2ODAvbWFwcyIsIE9fUkRPTkxZKSA9IDYKW3BpZCAxMDY3OF0gcmVhZCg2
LCAiMTAwMDAwMDAwLTEwMDAwMTAwMCByLXhwIDAwMDAwMDAiLi4uLCAyNTYpID0gMTc1CltwaWQg
MTA2NzhdIGdldHJhbmRvbSgiXHgzOVx4ZmJceDVkXHg1Ylx4NjRceGJmXHg1OFx4ODkiLCA4LCBH
Uk5EX05PTkJMT0NLKSA9IDgKW3BpZCAxMDY3OF0gYnJrKE5VTEwpICAgICAgICAgICAgICAgICAg
ID0gMHg1NWNhZmNmMzUwMDAKW3BpZCAxMDY3OF0gYnJrKDB4NTVjYWZjZjU2MDAwKSAgICAgICAg
ID0gMHg1NWNhZmNmNTYwMDAKW3BpZCAxMDY3OF0gd3JpdGUoMiwgInByb2MtcGlkLXZtOiBwcm9j
LXBpZC12bS5jOjM4OTogIi4uLiwgNjhwcm9jLXBpZC12bTogcHJvYy1waWQtdm0uYzozODk6IG1h
aW46IEFzc2VydGlvbiBgcnYgPT0gbGVuJyBmYWlsZWQuCikgPSA2OApbcGlkIDEwNjc4XSBtbWFw
KE5VTEwsIDQwOTYsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURXxNQVBfQU5PTllN
T1VTLCAtMSwgMCkgPSAweDdmNDhkNzljMjAwMApbcGlkIDEwNjc4XSBydF9zaWdwcm9jbWFzayhT
SUdfVU5CTE9DSywgW0FCUlRdLCBOVUxMLCA4KSA9IDAKW3BpZCAxMDY3OF0gZ2V0dGlkKCkgICAg
ICAgICAgICAgICAgICAgID0gMTA2NzgKW3BpZCAxMDY3OF0gZ2V0cGlkKCkgICAgICAgICAgICAg
ICAgICAgID0gMTA2NzgKW3BpZCAxMDY3OF0gdGdraWxsKDEwNjc4LCAxMDY3OCwgU0lHQUJSVCkg
PSAwCltwaWQgMTA2NzhdIC0tLSBTSUdBQlJUIHtzaV9zaWdubz1TSUdBQlJULCBzaV9jb2RlPVNJ
X1RLSUxMLCBzaV9waWQ9MTA2NzgsIHNpX3VpZD0wfSAtLS0KW3BpZCAxMDY3OF0gKysrIGtpbGxl
ZCBieSBTSUdBQlJUICsrKwo8Li4uIHBhdXNlIHJlc3VtZWQ+KSAgICAgICAgICAgICAgICAgICAg
PSA/IEVSRVNUQVJUTk9IQU5EIChUbyBiZSByZXN0YXJ0ZWQgaWYgbm8gaGFuZGxlcikKc3RyYWNl
OiBQcm9jZXNzIDEwNjgwIGRldGFjaGVkCg==

--_002_CY4PR11MB1320D6B4887D0EFBB6C188FAC5479CY4PR11MB1320namp_--
