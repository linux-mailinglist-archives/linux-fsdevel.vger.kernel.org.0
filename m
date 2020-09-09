Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B965263406
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 19:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgIIRNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 13:13:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60968 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgIIPcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599665544; x=1631201544;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=D3BzYYfTJvwwok5adP1N92MBzfBU89uwwWMLNXSPdLc=;
  b=EIEHwNkO6UmQdXnAVbnQxBsqgmPIh75d+AjsFgNCh2V2OmBLtmSdQl1t
   zAOoBxutti+7oQLL0Id45WdqJwXoN9/85d/ooB1S0gREKqfHd1oFtsiJn
   GpR9Vt9b0PywlcGw/cv8xvcR2uRF/3R5+tPNxZF5kJ0liwePHQueizak3
   FGclv8tyQuoDfUjHk2265hFoFgI/fCEpvXxPcFoji04FYI5D26/dS0ra/
   r58GFYcNzyvFPA35DP1ZqIZwBrLkTf9f+ynz/3oQbx2bbv+WfwTnkG/eF
   aX2QlHkDjfTs41oUGkcglsrtITBUbKUfXzkUrx5BmA38kz1kx6h8qgqnl
   w==;
IronPort-SDR: t4sdaL4ZqHk6vZauMfQ6IQNQU7XycvdzoR6uCS8kOoUCiA/UH+bpQGHPCMGDcyN1s380TtPop/
 Sgd2AtCQ6IAsLS/G8WzXXOD2gzNuKkGWY+aZdUUc++jXcAKiQFOUQSaRAE6qaP1EhWCwF1KUqt
 lfA6pPfvRD1zunoA8HfhJJlMUs4FKKcGdhEWnrA0pu6BlywpRn1N28MHD3BsXCG+K7xPLCPH3k
 q3d6PBKND3oVZi22T9+OD9W2uuxsZsyYb4SNai5v+5XJBLsrb+/lGLDdhHECzimibpBYrAyDji
 RM4=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="146930521"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 22:43:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmx0xoqbFfnZ+zniebwnwwnOqvOi8zyiIdqqSDGz7hZ40MFx6BXg4f1sMW4F//NJru2akdKyyUZiGfbwLP7VTkPidQoufRTQKrLFY3TBwk1PXNM3YaqxUov38TlpkljG/7tZCZjbxlYz05nPiB6Yv+qgTTyUZQLWrWxKHDbzLmiKSm+1WIBtnXW+oJRyC72KuDM8cGVewMtzdk+PAOCjGjX3h/qkwhW7mZ+G1upgYjxC0ww9vpMowLNRE635xYN1i9WeBe08mql36wMTfyAdQ2wOp9O7TwUqEpcShw+Nu48WdvTWPG9f3jKej/LPpdTAqNGyvLpF9g2Q/PO6fyhPHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7AlYBNoTz0Hsh4Ch28z3poeBLBKd1n5tpJVDYdlMnA=;
 b=TUfjT6b5YlKBq64yRSMkEpzmSdU8XvNqzzbIehav89UDB3CZRLdtKR4DudJRaAl16E0GLjoaw16Q1/wm/IQQ25RGDrDbxdNYHekb0okclZmLoZ87yArBv5aDE+sfhJbPG/mhkV+n+sj7LbTUden1ZaaCvMVfM+BXnDRtkvOSRXspv1UyanvX/vL4P3CcV1rz7g3z2ITEots0Dbibr1WcXi+M8u1vNqUtzriVVH68VlJu1F0zVJ5C2OD1fhqTJblIS6g7+Iwx2Ggr/YbETi/JtkOel1uwkKLiWp2sbGkhSpWviUn2zV7FLpexc1Dr8+/13NaXHJisKdGVpj6IZC8dvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7AlYBNoTz0Hsh4Ch28z3poeBLBKd1n5tpJVDYdlMnA=;
 b=N6h6EebHBKLMtqIRFSwN7tu0Nj0tDQJoaFHm6kjXlu+yrMDZAU8psH1BDaClB63y2fVb1xdwdM/R21HiVdrzZ/+IVQrIAtY5c/mlvSQirs2otxIJnZIkCfXg+1do2wqwz88xLoY1oYiUHgLbkkRiKZwC/spB1kQLBbyKuyqwFWE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4239.namprd04.prod.outlook.com
 (2603:10b6:805:36::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 14:43:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 14:43:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] zonefs: introduce helper for zone management
Thread-Topic: [PATCH v2 1/3] zonefs: introduce helper for zone management
Thread-Index: AQHWhpOxT9iaYe1GVU6sZ4ZNJmh5FA==
Date:   Wed, 9 Sep 2020 14:43:18 +0000
Message-ID: <SN4PR0401MB3598E56151AED9E065DA0D6C9B260@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
 <20200909102614.40585-2-johannes.thumshirn@wdc.com>
 <CY4PR04MB375130E0FFC0A1438D346E89E7260@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:2cf6:d0e8:5d46:4118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3245af0-4adf-444c-017d-08d854ceb127
x-ms-traffictypediagnostic: SN6PR04MB4239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4239286AE4BBB90C1C79BE389B260@SN6PR04MB4239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ciksE/+v78YIo0RUIVdtO2UPQhMF+8S+9tcCHe80xItKDjNNqp2kyD+7b75tx23cwAeLnZfwyrGnfdNKemp2IFks50C40WETz+l/lzh+wvsQ2CTI2dzXBZSWmhYwCTCHv38rqJLBYsHouhcL+fIB6Jzd6IMh/LF3SaZDZ/CvBksdsmmsXdY7QbWCpbCi+E2QMEwR4Kb3y0EyeXuXE4y59NbvR0vINWcTEdVUDl7ReRIkFp+yGExPEk7nTRJHQvuZBWWt9ryVLEtpQ34VpT189wc9q4ZrmyHZSax5wVVgWRBtv2mm07/TFIw5rNSFcTf688clVohVedz4EUDeQW49Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(33656002)(8936002)(55016002)(478600001)(316002)(8676002)(5660300002)(558084003)(4326008)(186003)(7696005)(9686003)(6862004)(6636002)(76116006)(6506007)(66476007)(64756008)(91956017)(71200400001)(52536014)(66946007)(2906002)(53546011)(86362001)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: sLO4FeJ5Eo5wb/lJl00nTSo5iVKLFvK45iBisGw/cmBFEL+Wbjo/9PyaAldnB3+sQ3Bcl+/7xeH/8awKwheZlO5Rj7wigpF+lk82VCcHLaQQ1YHosG2W1ELYYYKy/b0afrqqgA2P53JzxTJfrCu2zNnPuyeQcVk/8mY7useRt8ssxfxx2xm4l3PYQgUFQL/EWukxYchM47tfIn+sL6KWXLeN3Q2zShFJ4SzBQPv/WGTPQWDv5SoN1GraK60TvdIX+p+SUK2RgnmqT/sKzIL+gWKVk0bV7s9ghs5W+pC7s6xh2zkL4MQ6TjYlTwRdT9hp5kC1f/zLkdj2DPF18pwIutkNgt8OM4LxGR/YuZYW4w5Wg8763yxXlTb7eVD1sJ20ESgiqa3l5Rnqf0jbnU2at8Qp/tF7Xf8ih8Pdd8IWc/floeUCGNDZkKWU5hrsTPctKcIY+H8snm4wn3hkZ6XOVBnJaQvIsnWDlnq5VbY3mv+SN57UPLfymYtLx+VuMmDHzMt3t9cuvOQ/KDyp2nj2rhPKoa/Jl0S3EkEEw1LIwBq7nmGV0vRDz8IAQ48BQQuGrah1vSGpUWl3fYEakj4xMKPJhrLj9pnC6Y/uTvs2RU+hF2I5VcIwGkoXFlGs3xiYLrBlOaIadyXoq4g1ceXxxsXHXGpmqm8idVyQbj2sy8iTcYrbtMfHyIHNpmZU0X79vwCJiEDCdM2XxLOzAkXqKw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3245af0-4adf-444c-017d-08d854ceb127
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 14:43:18.3635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKfaVMiIQNfBr087p+NpqNWYG//zqb4plFcLEyWizMR8u/73Nb73hUJriIK9T67HM2r54Ck3Qrs0tKvB0aPTvJ58EEXtrX8pCVauk9SSGJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4239
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/09/2020 14:43, Damien Le Moal wrote:=0A=
>> +	if (ret) {=0A=
>> +		zonefs_err(inode->i_sb,=0A=
>> +			   "Zone management operation %s at %llu failed %d",=0A=
> It looks like it was not there in the first place, but there is a "\n" mi=
ssing=0A=
> at the end of the format string.=0A=
> =0A=
=0A=
Fixed=0A=
