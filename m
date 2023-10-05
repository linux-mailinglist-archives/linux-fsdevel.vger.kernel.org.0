Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0127BA744
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 19:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjJERFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjJERDw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:03:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB23211B;
        Thu,  5 Oct 2023 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696524640; x=1728060640;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pkuh6F4j9hdpmR+SvRe/lkpJXFBBPovwAh1qjDJafF0=;
  b=bM26kUdEOFULmyutFz7fRgdeOBMCGMeyFOqUwJeh+JEK4Ml1s+W0Asg9
   +SJ3pO7NaGgugmOYK34qnXTOPeOsMX3K3+8TEFMeBrwIvyTLS42NYEcnj
   iLl+mt0SSd+VlstJ57Aj51zQ2IX6tZpR+XaaNOGcl48Avi4EnGfUPm5iJ
   fXU1sw/SdXthlwI4L3gWt+r+yBaFu5Ylhi37hcntq1dcOKkVAB5tg7nxp
   BQAUvZNQ9ucJNtxWO6bzLhVkQFtlAgezjbDFrMDTrRgCmE+3S+04WdPp6
   4IaVAlbJbGHJhwIBJZWbMG8FhVrTI5a/rFe7AKOdiuoXDsGrsGf4p3xjE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="373908867"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="373908867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817675835"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817675835"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 09:50:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 09:50:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 09:50:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 09:50:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6O6WBpBunBLUtc2JgDJwJsMsQNsaDG0YmEe2sce7IAPYIDpz4yBWVwqI49vn/lnlBV8rsKnHUmm9tGKyQlvnIAoajHDXC3a/Y/EQM3vSnHfbodpXQTbuxPa0808cCrHBwbOQ7TPSqHWHn0ChYKFh1om6NPpvGdqIQJLZpNBOfLjuCqTdXKFFjLVBJk/UnxLDJeyZ4tEoZTP2fBvnJDpeXJdrU/oPjdfrWmlFhKFxQufsmEq6uQDCf8d73rLAP2mrosaYdHLtAhkQ5TxGhAqzyzssL/1QdFlT6KuYjKZD0Cb3tV8hfEycJFhcsD0BA9F0YbZKftwtafNNQj5rN2ITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npjARfrBEimg1X1iWcgIg+ASZmeCinUyqKfPKPwl7Gc=;
 b=NOCEluT/WBVDIgkznePaiA61m8X1YL7dWuhMCljCc3JSwVg8CCsdRgYNaZ9rI2+4goSw4em0Y77z79aoII7xGE8beKkNLjvwFZ+2OFegt1+iUsLFGysM0+8QYo3nQ15Ycn1S2EqpY1hf8Y1Ca4c6iC69nLVDoaJv3YqpiIJTsLXO36y5uMcLZxOeimQWKCihXYYViENdbHTnVAh3RgF6dhk3CCwo0d4hDelMjwNo++eSD58s45ujZYqzkiB9bhojU98rUZnnRCPSvUuqI9w0Xwnb4ZwU39TYcNrNqslNB6TvGG8zPsG0rUMEDJCFIq8KXtea5nYJgWnsU0bGLpBIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4107.namprd11.prod.outlook.com (2603:10b6:5:198::24)
 by DM4PR11MB8090.namprd11.prod.outlook.com (2603:10b6:8:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 16:50:27 +0000
Received: from DM6PR11MB4107.namprd11.prod.outlook.com
 ([fe80::b518:f82:13e1:5ffa]) by DM6PR11MB4107.namprd11.prod.outlook.com
 ([fe80::b518:f82:13e1:5ffa%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 16:50:26 +0000
From:   "Chen, Tim C" <tim.c.chen@intel.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
Thread-Topic: [PATCH 8/8] shmem,percpu_counter: add _limited_add(fbc, limit,
 amount)
Thread-Index: AQHZ81D2qSL1dIbwckizsiqlrxTnkrA7bsXg
Date:   Thu, 5 Oct 2023 16:50:26 +0000
Message-ID: <DM6PR11MB4107F132CC1203486A91A4DEDCCAA@DM6PR11MB4107.namprd11.prod.outlook.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
 <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
In-Reply-To: <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4107:EE_|DM4PR11MB8090:EE_
x-ms-office365-filtering-correlation-id: 2036f316-631e-46c6-bed8-08dbc5c32cc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bKGMmPbtg/PiCIlVRjhWt++rC7aqFWb/uu6es1VC5kkowAWXo0VlhGYfW6ypU36qdhPuuSvIPXPPsZPzovD1YYKcl3g4ROy05OZiz1Bn5BC8BQUeWFYcWNdnGov/apVBiijgPaoCsG5j+CHq5X0G2XMNNSA9hmG01U8pi8FsKIS/n6souPFlfH7zBiTFmjQYu+Ffv04/9z5TlkgBhNY3jSWNkcv8Dt7nvPovCpokqt61C80fce1dlpJFMP9dmPuAqvRp+mA1Z8PsmMq3GgbLP4lvJUs1XpIFQJJWfXncnT+LhcoLqaBLs5kdZ/LBqg+eGzrwCCznONzi04ikcJlsLs1LQDYUJiq9ZITLS9H1PwgVndDPbNmJVSP+3SF3qRhIIKNWxV7zLB3+B/ljvgwWANs53v/UlTkooY5QnlNUkC3yq+6RDsm+deXXO3tZTolp80ZlXm7pOlkbpicsg4lmeqkaU9mIfY9t1kFSTzoWCPWf/SCoxHFZS4554TxBti2vSQN0NywYWpG14Vg+2jtCLyVKKKbPdv96Q48UmwRbVc9yzL2P6Y5sB2ORxCXtufgmv11abveX5JDbCKQPoMxL9MnkHmPL8zDHDCnOQ6K5f1WflsObu7+C3/qeul/hYv80
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(38070700005)(82960400001)(122000001)(478600001)(86362001)(33656002)(7696005)(6506007)(71200400001)(2906002)(9686003)(7416002)(316002)(66946007)(76116006)(66556008)(66446008)(66476007)(64756008)(54906003)(110136005)(41300700001)(83380400001)(8676002)(8936002)(4326008)(26005)(5660300002)(55016003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?88pxhaWN2lYv+Urf/dOaTpkNZlxMmFlDuhE2pv+5UdI5pVSfuz57MfPZTvpE?=
 =?us-ascii?Q?/oAS58ErGXmUkA1JZGF0AaaJ4FIIPAfx2p+bDGL/I6v8j2amf/t3k7RqEP8q?=
 =?us-ascii?Q?hGqYehskm68X5NwXF3hEECLyNAVCU1jhy6XYnmkcfIbqGtflExGQes//I/+9?=
 =?us-ascii?Q?ULBiezfsnbGr5fGrWnuHEcssduieAZCgX4l4inY5CFgJqCiljmEBpuCm85wM?=
 =?us-ascii?Q?zRSE40QyJ/2k7+sJxwtmCXGYgHjSwa1BfZg3jr0MEDKtdDDRpz6bYzs0Leho?=
 =?us-ascii?Q?zEeo+K4L7ah7EOaIBm9zDSzO9qAbBjdlDxaOt7cFPnNViFwzaxCQus/rGHjV?=
 =?us-ascii?Q?iMbDwISA4qmiJmhHFhz62UsUZx2Or3FuWhswRlbpaT4fcbrr4o2ldqv/4XO2?=
 =?us-ascii?Q?IvCF0+3cT60n8cCxkhfsH7qvh+HwJu8e4BdaWrWY5WvsTH4QtFLmRRY5jBvU?=
 =?us-ascii?Q?T70KU9IXUnIqo4MvXFyrz7zn4W/QhxcpvUtwkwGiR4Bcws/1BOc1ewcOaxai?=
 =?us-ascii?Q?lahziywVfDji8+sP22Hju/uIqcVS3okV3rxAvFUvCWPenezlX8Nt9zX5i64s?=
 =?us-ascii?Q?VdTbyVX6Htskdj9S2qrceKJDenJtd4bjhKls5eKb6eup4bdAVryfSMTjnSba?=
 =?us-ascii?Q?s+1PRXwycXx210nTP4pWi2KHUnedqL1zqq0NWrGn/2YfayoheHp3Id/dpidY?=
 =?us-ascii?Q?1cEndConExKMbI8oKLWYBc5Jsd1QTvsXxMFn8jf+OberLMrNvU+roJD/F3ue?=
 =?us-ascii?Q?cUhyq6XH1nTQMHXf+Kb4DpIOZNOQEjcZ7RRaLVjLG5pBLRKa5mgiUidqjcK2?=
 =?us-ascii?Q?T8NH/PDsOeYbu0h/2My1QcqlfrhQcXNjLEGvoZR3Lb6JpORxd+5fCpwlLnW/?=
 =?us-ascii?Q?lbakcqkO15SdRNi/wjH3EVs4P7ZrG82uxYTIL7xnk/MZyJwPknq71l3+da8B?=
 =?us-ascii?Q?VPwJKWj4FVVdDv+B5khf7ECqfXTZKzkYu7Z83AhWqHA0qPNaXusSkmAu+TFT?=
 =?us-ascii?Q?I3axYtHSACp/Yvn+7KSBMn81XzPpOXf8AvSMPHuLzucwdhW/UMAAxEoXLaQt?=
 =?us-ascii?Q?hNQPmBCo7Y9w95kv7N0UwMYGbhZ5gl04NSyRVyx45vgiMjhmvtH1KIDP5fel?=
 =?us-ascii?Q?9RnfECsQ7qibT6Hc3Xf3Nv+isXgaz6tccdyEH7QnN93sTZYj6mSmEMGfRHc1?=
 =?us-ascii?Q?k5MQzfriU1XnwLeOtldsQA+FS7X/aXPY3N9xPtSQPYhvlt0Hldy8vywIYML+?=
 =?us-ascii?Q?xijlzbTr+Zf+PSjTLgYLunWQxjdfZkQZAljhACSQFSWUYw6OoGH1CG4xVWWm?=
 =?us-ascii?Q?J/ndnKKFGGl3Mh+9WB8wsM1Z9merHcEjGjcT7Ss6b0idsUeqZJ6+HoCISa2L?=
 =?us-ascii?Q?empEooPj72x6s2lee5dlKwjx0ii6T/0bk9sHKXWx0/QB8FMiAjEKlqA20NXg?=
 =?us-ascii?Q?LK2AFy4wfrURPKF9nsppW8sYDcw+/Sloo9bntIdA6UGeQbEEuwjHH65jP7bF?=
 =?us-ascii?Q?Sf2ms8sIgpD7sLS0e9v5tObsA6rM+Qhar10iCPl42HoDiANleeYHHX13+pUW?=
 =?us-ascii?Q?7i6U59cfahlagnHKKj8sHIOPCBitVRa7anCpGOyz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2036f316-631e-46c6-bed8-08dbc5c32cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 16:50:26.3184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w00ybMg2itw5N5dNvZ6HEgHdvwvZjd/g9P2Mr1Fm3EDWTVKfhDTkVIAjWvflVNAF75F+lwV36dyQR6nWYvNbbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>Signed-off-by: Hugh Dickins <hughd@google.com>
>Cc: Tim Chen <tim.c.chen@intel.com>
>Cc: Dave Chinner <dchinner@redhat.com>
>Cc: Darrick J. Wong <djwong@kernel.org>
>---
>Tim, Dave, Darrick: I didn't want to waste your time on patches 1-7, which=
 are
>just internal to shmem, and do not affect this patch (which applies to v6.=
6-rc
>and linux-next as is): but want to run this by you.
>
> include/linux/percpu_counter.h | 23 +++++++++++++++
> lib/percpu_counter.c           | 53 ++++++++++++++++++++++++++++++++++
> mm/shmem.c                     | 10 +++----
> 3 files changed, 81 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter=
.h
>index d01351b1526f..8cb7c071bd5c 100644
>--- a/include/linux/percpu_counter.h
>+++ b/include/linux/percpu_counter.h
>@@ -57,6 +57,8 @@ void percpu_counter_add_batch(struct percpu_counter
>*fbc, s64 amount,
> 			      s32 batch);
> s64 __percpu_counter_sum(struct percpu_counter *fbc);  int
>__percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
>+bool __percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit,
>+				  s64 amount, s32 batch);
> void percpu_counter_sync(struct percpu_counter *fbc);
>
> static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 =
rhs)
>@@ -69,6 +71,13 @@ static inline void percpu_counter_add(struct
>percpu_counter *fbc, s64 amount)
> 	percpu_counter_add_batch(fbc, amount, percpu_counter_batch);  }
>
>+static inline bool
>+percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit, s64
>+amount) {
>+	return __percpu_counter_limited_add(fbc, limit, amount,
>+					    percpu_counter_batch);
>+}
>+
> /*
>  * With percpu_counter_add_local() and percpu_counter_sub_local(), counts
>  * are accumulated in local per cpu counter and not in fbc->count until @=
@ -
>185,6 +194,20 @@ percpu_counter_add(struct percpu_counter *fbc, s64
>amount)
> 	local_irq_restore(flags);
> }
>
>+static inline bool
>+percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit, s64
>+amount) {
>+	unsigned long flags;
>+	s64 count;
>+
>+	local_irq_save(flags);
>+	count =3D fbc->count + amount;
>+	if (count <=3D limit)
>+		fbc->count =3D count;
>+	local_irq_restore(flags);
>+	return count <=3D limit;
>+}
>+
> /* non-SMP percpu_counter_add_local is the same with percpu_counter_add
>*/  static inline void  percpu_counter_add_local(struct percpu_counter *fb=
c,
>s64 amount) diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c index
>9073430dc865..58a3392f471b 100644
>--- a/lib/percpu_counter.c
>+++ b/lib/percpu_counter.c
>@@ -278,6 +278,59 @@ int __percpu_counter_compare(struct
>percpu_counter *fbc, s64 rhs, s32 batch)  }
>EXPORT_SYMBOL(__percpu_counter_compare);
>
>+/*
>+ * Compare counter, and add amount if the total is within limit.
>+ * Return true if amount was added, false if it would exceed limit.
>+ */
>+bool __percpu_counter_limited_add(struct percpu_counter *fbc,
>+				  s64 limit, s64 amount, s32 batch) {
>+	s64 count;
>+	s64 unknown;
>+	unsigned long flags;
>+	bool good;
>+
>+	if (amount > limit)
>+		return false;
>+
>+	local_irq_save(flags);
>+	unknown =3D batch * num_online_cpus();
>+	count =3D __this_cpu_read(*fbc->counters);
>+
>+	/* Skip taking the lock when safe */
>+	if (abs(count + amount) <=3D batch &&
>+	    fbc->count + unknown <=3D limit) {
>+		this_cpu_add(*fbc->counters, amount);
>+		local_irq_restore(flags);
>+		return true;
>+	}
>+
>+	raw_spin_lock(&fbc->lock);
>+	count =3D fbc->count + amount;
>+

Perhaps we can fast path the case where for sure
we will exceed limit?=20

if (fbc->count + amount - unknown > limit)
	return false;
=20
Tim

>+	/* Skip percpu_counter_sum() when safe */
>+	if (count + unknown > limit) {
>+		s32 *pcount;
>+		int cpu;
>+
>+		for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
>+			pcount =3D per_cpu_ptr(fbc->counters, cpu);
>+			count +=3D *pcount;
>+		}
>+	}
>+
>+	good =3D count <=3D limit;
>+	if (good) {
>+		count =3D __this_cpu_read(*fbc->counters);
>+		fbc->count +=3D count + amount;
>+		__this_cpu_sub(*fbc->counters, count);
>+	}
>+
>+	raw_spin_unlock(&fbc->lock);
>+	local_irq_restore(flags);
>+	return good;
>+}
>+
> static int __init percpu_counter_startup(void)  {
> 	int ret;
>diff --git a/mm/shmem.c b/mm/shmem.c
>index 4f4ab26bc58a..7cb72c747954 100644
>--- a/mm/shmem.c
>+++ b/mm/shmem.c
>@@ -217,15 +217,15 @@ static int shmem_inode_acct_blocks(struct inode
>*inode, long pages)
>
> 	might_sleep();	/* when quotas */
> 	if (sbinfo->max_blocks) {
>-		if (percpu_counter_compare(&sbinfo->used_blocks,
>-					   sbinfo->max_blocks - pages) > 0)
>+		if (!percpu_counter_limited_add(&sbinfo->used_blocks,
>+						sbinfo->max_blocks, pages))
> 			goto unacct;
>
> 		err =3D dquot_alloc_block_nodirty(inode, pages);
>-		if (err)
>+		if (err) {
>+			percpu_counter_sub(&sbinfo->used_blocks, pages);
> 			goto unacct;
>-
>-		percpu_counter_add(&sbinfo->used_blocks, pages);
>+		}
> 	} else {
> 		err =3D dquot_alloc_block_nodirty(inode, pages);
> 		if (err)
>--
>2.35.3

