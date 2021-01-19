Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81112FC258
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 22:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbhASV2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 16:28:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:42599 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbhASV2b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:28:31 -0500
IronPort-SDR: 72ni/KFBgk+YP/Wlm546mnDbqjAtJy7EOtkbD7K1Rr3Mw75IifTiqng5YYimZM1fvMUo3xqq5V
 uAgtB8IwCXjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="166664203"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="166664203"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 13:27:41 -0800
IronPort-SDR: P6ghof8VsZCwvLMgDArcumBkIipxBpZWHcQpMan8DxUGhHvmA2hVZCbwDoMwDBg0YOm7K/1Zj0
 m8FUkoXD5QiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="569864077"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga005.jf.intel.com with ESMTP; 19 Jan 2021 13:27:41 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 13:27:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Jan 2021 13:27:40 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 19 Jan 2021 13:27:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xpx8CztDYbWxOvj4tZ3WJqq4vyT09/rDkbBk2MBz3z9Ocbwf16lIdlTkz1Mc0iJYqgBWpeLcUMv19Aua20UM0efnWeFR6eLJ2JCCCRYZHT5Zt2mX3AR4WgIX65nCl/PIr71+6aHH1ateITVQTclbCn8h3bljDwjei5f8kxR2UxFhSLXu7MTI57EqjVfM3a0UqWa3eRKaOw9LcqoWYrnPvoOIh8HuRFGkmG9EhcNUxwG8JxxeKueN/6YfMGxVDje5vzem7Dv1XAOsXlpjCHWLyuna8EPD2Mjm20HWOgxO7RMz1d+a5bHZ/jrjE7gavcfTOmlXeOzFVyQWt8OkllJQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGu50+mbopfR/Rfngtz2ffbbdyYso5DxG/Ys5uymjl4=;
 b=mE7CYaP+fy/Mw5lu2a5LnOtKPZjSRQsRSMI0kVVHm6Axj16Wb1ndvfTju9k425AD5SDUXhUPJDHXYRgTJfT9EmbZWnvKUDbitwJj6b8PpZpnWIkqpUKZLNuArD8s8iZvUnx+ucyv9VrC/GOs2xjqHlw6H18FWkj/GoLQTTkeMNT2sPoOjvKdMTX/30u2NUS9azXpXkp4RFzPbmg69mP7yV9ty+mQikLqNOXcHQWFC7P6Rif2nKc5mS70O93rA+mU9LdP+Waslb4FaaeXPM0OHAZy2PEYf44xeKFtyoWHnqrqSQmLGAJY2VUSupYwuQmkfY+FP24bAz4s8ll0nuX2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGu50+mbopfR/Rfngtz2ffbbdyYso5DxG/Ys5uymjl4=;
 b=dYH+bgyHvRIyqmj//v04ict7TB+xHgSQY1AFumZOZcPnYHCIIgDKKyuLq0I91O6GZ+fR98SPcPQGSqjt0F+q0EsfElCFsGOOb7bYy3A8syrfa8NekuLuvSn98lCtStkcEzUksUvMuDm6oU8pGXU+qCqsmLG2wqxUfTwTL5GQz4s=
Received: from DM5PR11MB1707.namprd11.prod.outlook.com (2603:10b6:3:14::23) by
 DM6PR11MB3753.namprd11.prod.outlook.com (2603:10b6:5:141::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.14; Tue, 19 Jan 2021 21:27:37 +0000
Received: from DM5PR11MB1707.namprd11.prod.outlook.com
 ([fe80::516f:5c83:c08f:9074]) by DM5PR11MB1707.namprd11.prod.outlook.com
 ([fe80::516f:5c83:c08f:9074%12]) with mapi id 15.20.3763.014; Tue, 19 Jan
 2021 21:27:37 +0000
From:   "Chiappero, Marco" <marco.chiappero@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linux FS Devel" <linux-fsdevel@vger.kernel.org>
CC:     "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Subject: Correct debugfs file removal pattern
Thread-Topic: Correct debugfs file removal pattern
Thread-Index: AdboFB18ZkWRHmjrQUqmo41EwPm22w==
Date:   Tue, 19 Jan 2021 21:27:36 +0000
Message-ID: <DM5PR11MB1707D6FCF5F9CDF83174B83DE8A30@DM5PR11MB1707.namprd11.prod.outlook.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [37.228.229.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff34ebf0-929e-4d71-dc46-08d8bcc10af5
x-ms-traffictypediagnostic: DM6PR11MB3753:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB375391BFE791981634EB391EE8A30@DM6PR11MB3753.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdB6PFBABOqJDX7TpCOKUsLDIvri4kRBhTFtyoOxwPQez9WK6M8PYvFRQ9bqkPVo92cLLiHHJ2HstXbuMecbpdHobGjxJHl/thwsxC79vEvTNQPLg8jzOJ0+jcidDHhBb3N0m2uPiPyBOUq+ToCITI+w6GSM68Ds4LsUc9+ttbmP2hrr6I3edZmHjUWjQIEXj/WHSscQ8c6NsMjTkUmS74ETAiaZ4zGzpOOp6lycPKiK5leHI/CzeJIPYmS8Fg/VvJa9zcS8ZxYSnWPbP5m9oEe6dMkiPgSvnH5PFLSQO1hHs8DyZpF0LJ4JkNzlIhCPkwYnizsDyGppzJr2jDERSn5PYIG5m/pKaz/Uv5ljhkxE2JYMl0uZGD5muYgHKWVBI4asntte/dVPqPVkFCUEfP0wq/KcTRLttVEVjpdfuYbH2s+S/Y48HeWCNICQqKMM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1707.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(64756008)(66446008)(66476007)(55016002)(66556008)(9686003)(5660300002)(26005)(66946007)(76116006)(8936002)(86362001)(107886003)(8676002)(83380400001)(186003)(6506007)(4326008)(7696005)(316002)(478600001)(450100002)(71200400001)(33656002)(110136005)(52536014)(2906002)(554374003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JFMePTLdOPvQ69haR4WwLAhKDEcqgkh0SXAvXLEPQNotxlSIOW8pAB8Ja4v0?=
 =?us-ascii?Q?UJtezxVg37dqZ5lBcrdpkaVCNBNWZCGliFqOWQJEFjwldLzb3WQwUoP2Z6ha?=
 =?us-ascii?Q?IIUj2k3V4TdZ05cUcPCAxhXETySEFplWs1nOa0NSeAbQ3EGesq1vMA3MNCef?=
 =?us-ascii?Q?4syASg9jnRJQY/OiGNziPzf4IOs9Fzk9eMWucy3JPJqYXt1u37HSaEjO8uLK?=
 =?us-ascii?Q?DDu6IrgXuBUbgminqnpoVOyLSZ6Fh45bg0QCH6I/APlyIcUuRVoLJKDYeUX9?=
 =?us-ascii?Q?5q6gQnHR7OTrKjqJ93+EGFG7TCeqEFppoGtVFXUYqc0p53FDn4f4rhJ9BJH3?=
 =?us-ascii?Q?9t0Eu7mX4h7vk/kqSuzSrtBW82KnvDK5mwmOF6g/AXnJf0lZl8QsTNbr8A7G?=
 =?us-ascii?Q?LZNBPJuo+uo0ppakPgeBomuT9ZePn4pSNcT7mlzcB6rN4wNZxD501Y8M7NW/?=
 =?us-ascii?Q?68BNNYnQ3107uHRoyfbQcWoGJS36aO04C3bp4L84kkD1RfcyT1aUmUwcVX5y?=
 =?us-ascii?Q?ee/+f7KE2rZAg77RsNhk75CuJSGPqjHZzJBW8ya4C6Vwxig/YAwcD0mkCGtV?=
 =?us-ascii?Q?1huic/lhlZ2GnydoyioPvtCl9lU/40p/5zo7ym6GIQr7G1+KQBECDeNrcWqp?=
 =?us-ascii?Q?/2yA4obRDhhOZItO0CoYb4GyXhIV0mwCWwDCYcRuB4A2TEONh+U8ACIgQXZt?=
 =?us-ascii?Q?+XQ6k7MX8gdArd3pkq2D0w0t6CaLh6BBzo/Y44bBRLXZP/FpKYICE8Qw88G2?=
 =?us-ascii?Q?94AlG6Jo5fi7iwqD664W4ssswps+BIa28AR58P2LyX3/W1n4NozPPVPRumY1?=
 =?us-ascii?Q?Fpi1HSo2KlRoWLlHeiS7TGz7QBO1p21I76Qr32JzCjtRlTw2ohgVetb14xvx?=
 =?us-ascii?Q?ZOTMAeDOEAcOksmuP2lmRpihb7p24PANg3AGbQe2rWZkGRdSzs9kU1vsvCkh?=
 =?us-ascii?Q?s1MLcxXHWytvbUX7z60CVuykayUweAgr5tDy2sqgZYY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1707.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff34ebf0-929e-4d71-dc46-08d8bcc10af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 21:27:36.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txgJLt9skVKCh2WzTumaDJv+b5l/CFnBt2itb/zYvLLunShINZr8krZPsQSYusGuZwErbyS8ztVT9Uy5ldfcEyTf42k2vbL526ng5yabrfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3753
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I'm looking to expose some information through a debugfs file, however I'm =
not entirely clear with the correct steps for file removal upon module unlo=
ading. I'm asking this because I would expect debugfs_remove() to wait unti=
l every open file has been closed when using debugfs_create_file (not debug=
fs_create_file_unsafe), as per debugfs_file_put() documentation:

 * Up to a matching call to debugfs_file_put(), any successive call
 * into the file removing functions debugfs_remove() and
 * debugfs_remove_recursive() will block.

Unfortunately it's not what I'm seeing when removing the module with one fi=
le kept open (leading to a page fault when eventually closing the file). So=
, is this the expected behaviour? If so, what is the right approach for wai=
ting, inotify or fsnotify? Any suggestion on what the best pattern would be=
?

Thank you,
Marco

--------------------------------------------------------------
Intel Research and Development Ireland Limited
Registered in Ireland
Registered Office: Collinstown Industrial Park, Leixlip, County Kildare
Registered Number: 308263
