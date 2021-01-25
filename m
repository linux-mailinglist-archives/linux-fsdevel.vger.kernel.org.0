Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643AE30329B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 04:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbhAYJWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 04:22:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13642 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbhAYJU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:20:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611566425; x=1643102425;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uRJcKx81fJuavLhsSBHghPySJYEvX4LQ0TuErL4NTzg=;
  b=j1kv9h2FsBZPzelQ8Fxd1W/rKRJTxc83WxnnOGywSDrWNs/z55Y2P6MW
   41EBgVRtzqZU2PB5nH14VH00YDLDsh2OR2wIGDfMV7Yzza0eq2fOvp9ue
   g+sipQbzaVKrUmT46JwnZkuD9dLoUkYosVyNWL2DUWzsBEukcHXdkcAlV
   BdD+m95kS4sfi6n5Jkta9y7WrWUfanPEPUX0epHHTGnq01gLGgTLNHFQC
   9aNnnlsDh0sTFHSosl7IZ6RIQXTNkngKL3hPkiPwu9xdos/G5b9pJwLIa
   fySnIOsO4lTgKKF+1x0Ri+xSyfCa2fFZxNfTsfDb5KPsf0T0OMjKv+zAs
   A==;
IronPort-SDR: zhn/mhSkpL7qGuxXhJ0xtJ/7i0RFoPqjKlWHjuDvOhkne/PATRNvBTohdDh9HZKHcvbSJWFH1B
 511DuWAizbYNJj7b3r9gF8xcFB/2si7S5dnofIYATUc6Bs74EZpiuKwQC7H6wX+Z1ZygZgMWKR
 i81AaZSZVCTckeE4vcj+AGw0YV6BD/A1SQgJ6pKe4iFpkOPspCsToWcPm+NL+JiyXtR9AzJe6Q
 EgkLfWeMqA8x1AqTbXIYwfA5MB8UgxBHKpQtLGvVpACfcaKKnB9zFzDWztKz0dcW/c3BgvHthP
 F88=
X-IronPort-AV: E=Sophos;i="5.79,373,1602518400"; 
   d="scan'208";a="268597579"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2021 16:56:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkNrUvmHLpj25Nxiix1MMviSb9jIMUd2aNMywLwfPwR5N53DUFUOpTSCZ/1q2HNNBUFDegQLjD1IgiH8UIf5IwlXmR3N/OjYswNIEaYwH7ua7G44KXrAzW3IM8d/hynGh6KY2MhtkChlL+pTXvzoXvf8X9idBe1GjKzpH6Gwa6qZx6C2rFFDdW8RWgGMoVw46bnjwQuP4cDSXTIOXK10UwR52d+51nZ0p/uLFG9kcLyBxGfDaoW+/tNl/JjalM1/XiSAZdp/7sgA3tVWUXzn0QbaX0+a+TLmExGBFl3Ti/wdBMDGqDe/qokvE8epFMtoHq9T1MUkO2BH7qJIpiGhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neMrZQ7UBSOSCTdytXEuUu6lfwZ+qXQU3ja01lwBj30=;
 b=EhUibeE4L39NAGgZ0xC5zjXf3LK4qe07kpCgVvMb+w1MXq2PU7ppU/NQAis8Vx6LyY2sKhya/7H9DRkEEDNIUe93nCEddRuy2GB98MhBy4Vj7nMMwDkxpeliXaoy5ipWAP4WH19cSz3HY7fBo5VtJw1C69qvcwfwBjGQoz5zzjs3Q4D9zng7r+8CGNFsTt2EZGxPc5IQOnxesVoJW6L/pT2W9CogFT9PaF4wDFIWNeIOEgINm5A9Tf69f6EVI8hMMsWePmUoMa5MWXPwF73LK2bPsk3kzm/sY+mCPlaG5jSyNcSEPsDtjF3hc1PlLg4nd848WhQ4MmshHDCNLfShnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neMrZQ7UBSOSCTdytXEuUu6lfwZ+qXQU3ja01lwBj30=;
 b=GcPtPRqNyY7h65/Il5bcvHFokJdmoqVaquXUYRpOdbOcTODmlCiJPmItt6blpRZvb0vkdoU/GgfQQnloplnNVw/FQJcE6ApPiQkVglTTn6jnKLC70uriCV+h0QbrTw05ElQtDidsF3eAeRT3dsvwKe3JtGR/HtXNUAAp1JronEQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Mon, 25 Jan
 2021 08:56:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 08:56:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v13 22/42] btrfs: split ordered extent when bio is sent
Thread-Topic: [PATCH v13 22/42] btrfs: split ordered extent when bio is sent
Thread-Index: AQHW8IfvPraG/TW9u0miP5VLw5sG9Q==
Date:   Mon, 25 Jan 2021 08:56:29 +0000
Message-ID: <SN4PR0401MB35989156A42BA764116B57B29BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <25b86d9571b1af386f1711d0d0ae626ae6a86b35.1611295439.git.naohiro.aota@wdc.com>
 <e265540c-9613-9473-f7e6-0f55d455b18e@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f1a20c4-1d86-4a90-5857-08d8c10f1b4e
x-ms-traffictypediagnostic: SN4PR0401MB3598:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35987308F2EE65A6298D7F3E9BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AW3XVbdVwUaltiF/EBegrYYou30H7ZklcrDW+vOr75hkLIqLg67pk20mY0ujkWDdxbbIeRK0fELlJc8lD2TlAMVXY9m3KjpvGTXlsP0VXDcu5fnzks/E/J35hw6lLBXrHDILR3QjdVM0sNncZ37zpyd6KG4Wi3fsTg7hYD2yoNwVRrNZ5FaV2OW+DAZWakjh9dl+X1DDPGH6/ndfB1fkCbcMs7TxNJeiJDdUtodfQVXt8Ap70bKlGYFvXBK1iSif2B+D+acdDaiQIF+33sk2r3i+DbV+vN32ASWYr21gndqqGQ9nXDSN5w7E6DPhI68lGranAzV3ghlPhmtqTs7Fw+18dc4k9qg8hL4RSMME4p2uDiciBlQB/6K7L3owIeTh+ZD6EH+HTvA/QMNfV3b/8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(9686003)(478600001)(83380400001)(91956017)(5660300002)(55016002)(110136005)(33656002)(66946007)(186003)(2906002)(66476007)(8676002)(26005)(53546011)(64756008)(66446008)(66556008)(6506007)(7696005)(4326008)(8936002)(86362001)(76116006)(52536014)(71200400001)(558084003)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SernjOzFRIJHdDNsrpUg9FdpM3zxyq2aIldlZGBWOrbbOXpB/HRARhc6Wy8N?=
 =?us-ascii?Q?d9qxNpqoI1o5NW8iZ2iBFaivmRXeutqc5In50KJe43gBzs0yzhBfml2czaCF?=
 =?us-ascii?Q?QqM9EoNiUobG1YRCV04NnoZmYVkiS8fBZ6tq/o+62D/nQI4InifX0cVMve55?=
 =?us-ascii?Q?eyYikcQL79XmhuVSVi1n44bjirYmEaKWV7hclX6VKvauEv9UcaI+iMIpP2VD?=
 =?us-ascii?Q?Ya0yX9iwCfnPQ4rMrW08G5dOgfIDLAsBgJn9Sh5eo2sru4QxT5OIO6431g/h?=
 =?us-ascii?Q?4H53urvBDw8s+E05qBSPrGlQIqEk6XPRENSaCYujYr1n3f9vwKty6079MWS7?=
 =?us-ascii?Q?W+n9W2e4K9TauC+ShUOsNPTrG8e7tUOMHMC3ep6B7JES+SEhajelTqaPSvq3?=
 =?us-ascii?Q?A3kwyd4sK1RUJAhOhgh12AM2ghHUdzHOttJ0R+QPwdUFio7LineEEZfWLB4a?=
 =?us-ascii?Q?2K0GPa/KYD8sWdbDyOXt5fEB+I5kReZjVNtyKxBIJRusqwUfjpwxEj9KzY9T?=
 =?us-ascii?Q?2w4NvlsrCeqLdpwL3kpXgloplXoPJVROg3vbGkKD+hWfdvDTnb5ygLr1pFWA?=
 =?us-ascii?Q?CPTFMe+lW0h4Zh9zqdIQ8gxor/7vztYl3QWpuqrz4h1Pgxf6kRY25G0p21j4?=
 =?us-ascii?Q?FPhgRJakn9HMv6mVFbkUUo4UFne3KLfr3QUHzj+G9WS9d05k8GoEBuRS5NbP?=
 =?us-ascii?Q?8D36tMcotzD9sJzw5XIyszmZsE/YqhFBpa3V1d7dVxXGLz8p2FJlrhOAFkye?=
 =?us-ascii?Q?yFOVfwzBSgth8yeJkEk+VNGLxER0xKBezueM/xAjcZEFvS21Sp8JZtN+MX6c?=
 =?us-ascii?Q?NVtJ9ReOIm+4U8A9AbFMZoIujpK3tgwx71g6o5QWpPUdQUPZzMR5GkdfR1Su?=
 =?us-ascii?Q?7XIGXi7KQwA7JdTbZ6aZXkyBOfafCSWGplfBeOMY67HW3xGdDSGdPPEf7sX3?=
 =?us-ascii?Q?4ON5UiFs62ig0ZrV6VQL4PasIjfQEBTbOjwq3seaIR9GnJJvHCybi4wuUcm1?=
 =?us-ascii?Q?I0OK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1a20c4-1d86-4a90-5857-08d8c10f1b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 08:56:29.9105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u83sSkE0zNQ516IbDopKU7cpQGcPf7LMzHk/uXBicnjGhUGUYOpQwBJ2iiT972wGnGNKgoancTcb5B28v4gic9DF3MKgoXY9yOyJeoa7HNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3598
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/01/2021 16:24, Josef Bacik wrote:=0A=
>> +	/* We cannot split a waited ordered extent */=0A=
>> +	if (WARN_ON_ONCE(wq_has_sleeper(&ordered->wait))) {=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
=0A=
Oops that must be a leftover from debugging. Though we never hit that=0A=
WARN().=0A=
