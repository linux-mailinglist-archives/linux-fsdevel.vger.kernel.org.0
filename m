Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52F5BE62C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 14:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiITMsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiITMsI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:48:08 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD96647F3;
        Tue, 20 Sep 2022 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663678087; x=1695214087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A6H5Nsr5nibKsqV7Vxrjp1UTysAd39TfMllrqRhEX0A=;
  b=Ku+NUSUdPlXwLrxLJLSI/98srIfxKE1/gkKNKXDPM3vviitWKCFfIywQ
   5HlTKk6DlubH6KEsaXUNX8O7LQg/EbMD/aKzOM2TiC3BlP5FOYC7rbc8p
   2sKTINDsCG74EwDwXN0ZSUg/ME/zGAi0/l5BCl1QUexqTNgrqy69LTi0F
   cxbyIK33ar+4etTWl6S2WgPKOdZ99vfDcdTETUfKuo8voQwyqlBGz/vG3
   gQD8VjIBJw8wVACXPBKyBB1WSGcf78XGnNIq4yJLUrDi0RZZYNswMbFk3
   KhjzrjebvSmKblWdvOBXUh9vKMto8WSnezOvWX8NhMlKqOJt3f8BUzzNU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301060932"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="301060932"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:48:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="707978103"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Sep 2022 05:48:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 05:48:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 05:48:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 05:48:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMsm5O4gIjNFWmCafplEAX0q98DFZS+F71dPUGWufRPOlO24DK1mD8VEybKvm0uQhJM68egJuAFHVpNIDz4ajvVGPmw2ChuJ1ASHRgkN8G80TR65h/lcYlMPqJ0TshT9oTxy3C5PLG508QvfOQIlHN4U9IfQ2sPnyJZ/+J0yF/7ITGPoV4UpByqm6z14EBSqICS7LG+G2NtGnpipdH5/mKXhqMzyptclPokdYu8a4pZc/Tqngi85FRan+jr9E+lmKboMhXc9kbwJFNlyqSI50Uh11Zoqwe4f2AUMrd/qf4ePidYF81Zfxvs3uRvVHojA//OhAp0zpRrHUVZBIWkTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6H5Nsr5nibKsqV7Vxrjp1UTysAd39TfMllrqRhEX0A=;
 b=W6W6bcxJlSCaOLsV0FQNbNTAYhM0/kV3ohjkI2bVitN9dqrF0oWg7GOk2P82x5MBWP516SC+gBDDjsQI9+Lv/0aiJFnvY8MSPUXa+gjEwXOd++efaLYzYUUyLDRNiGFUPvdclj6pAUATlYGr0rT4pCpfssZok8caGa/pkB6oudHYhcOdZ+7XWNS6tx0TgtA7kR1wFf+fURFJSCB7YF1JS7zkC+wi9PVU5FeOtiQ/TioeYJfxNLo4v7gKygNBGyXE6c+kgOTtAfbGL7BCQXMp8CwrO01x2nFoSztuBLGEAp1CX2Fr1Q8UsFka/VP4wBUiHAKDS94Eaxn8Z/DDPBHFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB7302.namprd11.prod.outlook.com (2603:10b6:8:109::22)
 by SJ0PR11MB5789.namprd11.prod.outlook.com (2603:10b6:a03:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 20 Sep
 2022 12:48:03 +0000
Received: from DM4PR11MB7302.namprd11.prod.outlook.com
 ([fe80::a69b:3f2c:3715:9c02]) by DM4PR11MB7302.namprd11.prod.outlook.com
 ([fe80::a69b:3f2c:3715:9c02%9]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 12:48:03 +0000
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eliav Farber <farbere@amazon.com>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hhhawa@amazon.com" <hhhawa@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: VS: [PATCH] libfs: fix negative value support in simple_attr_write()
Thread-Topic: [PATCH] libfs: fix negative value support in simple_attr_write()
Thread-Index: AQHYy2W2/Hzoy8Jl3E+JEil3tWgDHq3nRYiAgAEBwlI=
Date:   Tue, 20 Sep 2022 12:48:03 +0000
Message-ID: <DM4PR11MB730285570907E1A77D5115C6E44C9@DM4PR11MB7302.namprd11.prod.outlook.com>
References: <20220918135036.33595-1-farbere@amazon.com>
 <20220919142413.c294de0777dcac8abe2d2f71@linux-foundation.org>
In-Reply-To: <20220919142413.c294de0777dcac8abe2d2f71@linux-foundation.org>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB7302:EE_|SJ0PR11MB5789:EE_
x-ms-office365-filtering-correlation-id: 3343d27a-5d0c-48ee-4667-08da9b065bca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z/Z+y/l2If0bO5ze4vdRu8wZWNbx+sgOTTUhFssckP7+lf1BU8VMJ9Fxfakz3MxX+4ApbbA5vWt/dv9WKNv//N0W/mtQzpLYZxbNxVujJzh83YUmRsNTFHzcfDp7RL9q8opQoAOCAw47v9PD+tMeSjsAoPtUsBeknfA4b3rXPUQ9oAK8lSqeTrCL3GUFNxEWb+/H1P9ZeYncaQbOiT39uP50YqcH/5AF2zogp3vsxExLZQpzbiNVQY2iOJcDgjzyxhd/UpP5+5MVzjX0yXQqvSYG1HdbUNOU+oDo3MlJB5cZX76FkWx6WtmI0gYAQCEfR/yeQm7nmHqnFeIEEqJLJboNAVk4gqM3lSinH/J8WEfkYDxeGtp3F4tpNmom1ad3ss0ih1lPV+drD8D64YQWYfKVZ7m94VBhVLl7ywe0oGYyZdXFbpuVmXTyVdE2WLe5hnevkyBjba8Io1X/0vqbAvJPsVcp2hEM49vl7+z8R65tfZKlktT5NbEpqRuMtBZolbswN+1zrb0vVgk947dMYwEU2pUwlvas7bVv/VxtNNSaXZLjQ0ImeBsOvAoPezxpu3kAYu2CFfHZIh/ATYOOu1h4/FQQYWJUkbuQsnOVZq527n6ra8E/kEoIpDAJGnz4cPCIJRFNGfObqJa25t8SDHpoomAyg6w5g2xSrLqnMeC/1XXWhEjYPvtnzzvnFmOtWpGDo5fF3qremAP7UVa3o8OvZZXT56T5hi+e1yUbi0EycYt97JpNDJNvunLJsfwQTlS6EZKw6VVo2oOCc6F1Wxo0yaLZ5m+fW4SzjnxK0+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB7302.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(6506007)(55016003)(110136005)(38100700002)(316002)(2906002)(38070700005)(71200400001)(82960400001)(66556008)(76116006)(41300700001)(9686003)(122000001)(5660300002)(91956017)(186003)(4326008)(52536014)(7696005)(64756008)(8676002)(86362001)(66446008)(478600001)(54906003)(66946007)(966005)(8936002)(26005)(33656002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tqy/iopRh/0u310TsOfkO9mZ3xpblhHOdUYkEXz0mwZmonl7iHoiymALbz?=
 =?iso-8859-1?Q?GpvtrKQ82Q+V0GgfdcOpbDz8Pmuz0mvSlnMr8ePbZOM3Lc0pjs7mh5/JtQ?=
 =?iso-8859-1?Q?Uk6rMAgNPy6Notk8sqGUQxAWE02T6z0igDZfAGoxax9EHhGEJbJYq8j6Ns?=
 =?iso-8859-1?Q?7firn3B9sAkKVZta/HTIJWWoD8WFoC6t830s278MyVguX7C3Yx2TuO4h8Y?=
 =?iso-8859-1?Q?wno/P7EwjUZ0jGGfOIm58rw2uA+K+JCf/9CBtBcf1paUdcNQzIN1JW4rPp?=
 =?iso-8859-1?Q?/AUcF+xP/thKKrXVKAJmMv1zjP6DOgSJ+SAolWfhu/EhrtI2SrlTg6w/wv?=
 =?iso-8859-1?Q?NnHB5E+9nwD45u/38oWlTr/dS0/CijoV7XxCWOBB7Cv2qp/8T4nOTUACDg?=
 =?iso-8859-1?Q?I7qJayZfyMLHyMK3WNqYflTjF//9lADH+DOtK6AJbOn4ZdqRHeCJyUaOhX?=
 =?iso-8859-1?Q?F+WM1YJetMttDtzCQ4caXU/HDE+qGAowH7m6Dg4etyDfCHA6aI0nca5xwW?=
 =?iso-8859-1?Q?cXtdVK+YelPd1Mq370ooX+rMnMdVfKXAzNFnpw/ofRZcb9JHuxOsFW0ED8?=
 =?iso-8859-1?Q?eEzOioVdlwhKtDZi8q+qXQKaQX8BLWxE+cpGOMyU49+h+vrrYNlXvOJRiT?=
 =?iso-8859-1?Q?dySfZgjSHBM2O3kCldD+PiWWt/S8nYKeApYFG+SI77QcDs6QZl0H3yOTAW?=
 =?iso-8859-1?Q?ZmF1o0ML6mvZIrDFdfWwyD96H7PmnXkDPs/MjGNWavqEYpJJiyDbWFU3eE?=
 =?iso-8859-1?Q?oZ43zmprkrA9yNL5ksNR8VZjgL3hKvqcPrAbB3xlAbd3FVtCpF+smpZ80i?=
 =?iso-8859-1?Q?pUNpMaJd7/GHCwesazb2KJpJV8imUInWb7bxuu3CYhqop2yQ5t5tenKNOc?=
 =?iso-8859-1?Q?h61DFYgQJ5pHpBHOVDsrEZu+fNjKVtUe5tRxgw0rySR9DHH3DhKiDkmNcd?=
 =?iso-8859-1?Q?v1LJwFztg7PBNBMt+dNx/oFzGwahxUzq0O3ix4rZdsMT7Eoo8i7D/+KadB?=
 =?iso-8859-1?Q?74Dko44S3xn4Gwk0zvE7xQe9lngLU6aZ8Yc9Z9+9MZzV34A1XGu/dLcTjw?=
 =?iso-8859-1?Q?gj35hNjY7osCZelRHM6Jfju2EEhZ/nVzOCl/wnEh8pPldcSgJqnhAPtY9E?=
 =?iso-8859-1?Q?gnuqVzJlp2WRsYszLVxymgcwa7/0kKP+JVjEUxUZfEREp1+YTKb3KjIYG6?=
 =?iso-8859-1?Q?/CaU/wQWyeoy5MLPTZuqo4NneemHwunldJCwPJ9k3C1Sk7+bk8ROQu32Cg?=
 =?iso-8859-1?Q?c/48ZzQK44gQfIdPASwUUkW8Gt+VAgtj0imJ0bwbnpcaaof5MkmaomC917?=
 =?iso-8859-1?Q?Y0bOySzyGFxnc8pPZGgvHIb6GL5OGn2qWzFhfa+jFDxAXnaA5a0pUFu5op?=
 =?iso-8859-1?Q?oEeL/0vur/CEesqcKzhJITL+OFhIR+Vwbim/MPyrPhyReS8xPeGV3A5mTE?=
 =?iso-8859-1?Q?UMe9e9P1lMYv3tEvlc7vUc5SzpxOKBvqbW8tzlpxI1cVIxnplUjdF60oxX?=
 =?iso-8859-1?Q?BJxR0zn6Uw/TtvUlVvMqHpWMISMR9V+Ln0Tp7xikC9LGCtzp031l+E5IbK?=
 =?iso-8859-1?Q?th9a2iW2GMgdgvtL28qXlPAKS3fbp4MRhYLDV9L+ezqF5DSVM3Q+b/+BSH?=
 =?iso-8859-1?Q?174ebdcEEVc5LI1iHrj1FJAPmVJ3NfiFWcllHkx1j+5pcET8dH683b1w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB7302.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3343d27a-5d0c-48ee-4667-08da9b065bca
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 12:48:03.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63gybPvGwHNtuvIv1pcJrF7Xd7/oyO3N3FTnZZecZVT5fN1IJKWf3yWg/3Yq+8JIxP/sogav30izIc4zJyUX0BY6+G4viO549wi+ijdCceE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5789
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
L=E4hett=E4j=E4: Andrew Morton <akpm@linux-foundation.org>=0A=
L=E4hetetty: tiistai 20. syyskuuta 2022 0.24=0A=
Vastaanottaja: Eliav Farber=0A=
Kopio: viro@zeniv.linux.org.uk; yangyicong@hisilicon.com; linux-fsdevel@vge=
r.kernel.org; linux-kernel@vger.kernel.org; Shevchenko, Andriy; hhhawa@amaz=
on.com; jonnyc@amazon.com; Akinobu Mita=0A=
Aihe: Re: [PATCH] libfs: fix negative value support in simple_attr_write()=
=0A=
=0A=
On Sun, 18 Sep 2022 13:50:36 +0000 Eliav Farber <farbere@amazon.com> wrote:=
=0A=
=0A=
> After commit 488dac0c9237 ("libfs: fix error cast of negative value in=0A=
> simple_attr_write()"), a user trying set a negative value will get a=0A=
> '-EINVAL' error, because simple_attr_write() was modified to use=0A=
> kstrtoull() which can handle only unsigned values, instead of=0A=
> simple_strtoll().=0A=
>=0A=
> This breaks all the places using DEFINE_DEBUGFS_ATTRIBUTE() with format=
=0A=
> of a signed integer.=0A=
>=0A=
> The u64 value which attr->set() receives is not an issue for negative=0A=
> numbers.=0A=
> The %lld and %llu in any case are for 64-bit value. Representing it as=0A=
> unsigned simplifies the generic code, but it doesn't mean we can't keep=
=0A=
> their signed value if we know that.=0A=
>=0A=
> This change basically reverts the mentioned commit, but uses kstrtoll()=
=0A=
> instead of simple_strtoll() which is obsolete.=0A=
>=0A=
=0A=
https://lkml.kernel.org/r/20220919172418.45257-1-akinobu.mita@gmail.com=0A=
addresses the same thing.=0A=
=0A=
Should the final version of this fix be backported into -stable trees?=0A=
=0A=
Oh, this rises the question, why the heck we even have the format parameter=
 to those macros? Seems to me like a (hackish) workaround against the known=
 issue which was introduced by the previously mentioned change.=0A=
