Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CF2A335F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgKBSxI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:53:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18047 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604343187; x=1635879187;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MfyU100BMtwTXUch+NQxsepxbECun/Jp06YBi9bOUU8=;
  b=oqBe3NWnJbjzSZ8L/JuE00Ndm/ouuyjBVe/4+5f69oEjWd0BWHPgfT0p
   JA908rq984An2QSuLLAgywejxv7vF8ipHqlzspOQCP0ItRpXblEsk3xqM
   z1s/7xeR+SwTYYz5ahpqFlzPBJmZZRDO9+fHfbVdKM1ZP6srGbvrvAiBl
   9cmw3VFJ6HrRq5toxKSubEjMa8723RRPRV1QvPPRzybJqEP3SmSVZTvLO
   b2YUBsjvWeNgthaRmBYcM9VxqlpVURlPnr9YOYoXavqK1PkbEJ8U3x6hJ
   LGCtaFrcXmwKi3OI5HG6a3HB+jUwWhGrXrEAa50SFc7tGCaFXfMjlonfy
   Q==;
IronPort-SDR: jgk68T5T1JN6H4umi9B1sWmr6eZwB/jj4k4i1bs6i8X7Da9ac5heh7a+DNlUwMbofC1Ci1nTQ8
 kSlQoAsIPlWPSFP606k0MTDfYr/oW26m0v0YO/G9eg8tL/DC/82Sae6/WmQPQLHOTNW0jqYOA7
 qlutksGrQTYCR377o7LKTkKsSpIdYxwIeRy1I8D7QMt7TGgBLoyYIYVzUM4fnTbYra7jEGHNaw
 KsFY6mULQGLRisWpSeS4HjWs4FDrYsxuTEIB4Rp1OpF0P/KD4Plmpph40LjkhCZbqeQcLps07s
 sGA=
X-IronPort-AV: E=Sophos;i="5.77,445,1596470400"; 
   d="scan'208";a="156014714"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 02:53:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzdOZQ3LzTGgzWrbJbw3NRy/PN+vQmAPZPNwlYld8yzmM8bOqaEIzHvmwKddCCxJtxOeHD3wVjQ1oM5NnNNu01lcltXZfHdTfYMUg2ywsMX9zvaB7SFlY2CS94xfJgHirZx8p6k2AJoNOVYP7xEp3kqRswjHJ3FujzS4HOQmi8WaVbB/y4WylXEN/mUJ8RvQrx2hS+3iqE6wsC8MDpYIA0YKQ+ijQStNv1ivhux52pCV8hEJ+Sg2EMrlaYWN1A4QkgHAoVn7lZDpYw1sknc0fIfjcMBdFMTE0E18Dm0hYNKjIvLSc4T+p9b6QAlNqj0IE7dHwEXr9ZCku2prsD+ZLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEebln42sqGA1PG7CKLeho7VkE21jISgr/xsy7X1koc=;
 b=OfSd3mV/MaB0nfwIJXrQOkO6HZ7C/yPvSu0T2IG79I+s3hvR0+ShqmhkW2N1Vf29/XiHq7YJ+YS1FpkkDm7gFRlyQ1o/rRhfkyFy6DCRFcB3zSZOYUdwL+uKRYlZ30ett+OnjDBVtijh991AV4A6uCTX9m2H7CUp4EaBs2u1VevpOengDnTlJvCz3Qpn6yJW1u3Y60eD+3wJ6EPrNaHCsT1iNAB1NHQJA6Ff6Mt7433mM7qGH78f/b32iA8X5kkpGxhCbXZ0jCzlS8Yhl0jHcYXycnHZmCBXAUl9EHFgaDumOA2Z8uSg/CbxkjNpxYpezVdVpW/yGDeuGc7O4w9wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEebln42sqGA1PG7CKLeho7VkE21jISgr/xsy7X1koc=;
 b=IpxcmHwM+0VGq3RFrkR+3I6eaVdH3tUdVV8S+gbmbpr3xtvcmNzmapuJoireUsFk/AuxuA67Ipsvk4rRppbwbgAbGAG1Pn2RmtT+i7iwpMw/bqIn718JK7Dr2bellPirILGU0Yo5fFX4DETsts5jAIQlNWqzrCbUdihQzT2YvWg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5407.namprd04.prod.outlook.com
 (2603:10b6:805:f5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 18:53:04 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:53:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Thread-Topic: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Thread-Index: AQHWrsP6KGClmxP82kqQJxWMXgFaaQ==
Date:   Mon, 2 Nov 2020 18:53:04 +0000
Message-ID: <SN4PR0401MB3598937F8C4499BE687667A89B100@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
 <0485861e-40d4-a736-fc26-fc6fdb435baa@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6b0c0f9-ee61-4b30-4c1e-08d87f6087d3
x-ms-traffictypediagnostic: SN6PR04MB5407:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB540720A81B0BD2681701D8689B100@SN6PR04MB5407.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hfQhtA2LStKN7vde5YibWH0J094O9A+1qpaoE8kJZXAuT2u8L755QPZsMF7TGYda9vOz2+7Q6SEcESEtoEdnRjFAf3qCWPl/jBmj68ateRzOKiRZa0hBWynRuqLGELJn7lERIgOquAmfovJA1N/wuYQ8cKfELTM3WnETZ1Eic7K5ckzJw8f4+CQHLU/q1OgRAf+3FVjVlmfictuLNUejAxtCORQxr/O8h8D2a/W9bjQT1TCj8UyUgp7ns6tthlSAAqjLQFvtT0iuGUKL1NV/47UVcDa04C/02zLWKqY3I8WzH1aSo1k3RKieviZe5zKS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(2906002)(66556008)(110136005)(71200400001)(186003)(478600001)(54906003)(91956017)(76116006)(86362001)(316002)(52536014)(64756008)(66446008)(66476007)(55016002)(66946007)(7696005)(9686003)(8936002)(33656002)(53546011)(8676002)(6506007)(4326008)(5660300002)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2JjlBeVytPboVrlq309J7seFryiKCKTRCu95Cr/wM2xnHaAUFXyBQVfMCYr+z05+4DaDr0yCPqXQoq/LKs/kEF3LRBF4/zPg/fQ9c01CBnfbZgRJEYpQefQJZ0TFZ1wJUIY22umEiYJjxw9HaeMNx+iIsunvWuobhLwhAUiRbbhd5/dxURs0KRygSdEbf84c/teA5qs1BJu+tskJ0EEY0jVHahgWSQe/cT1BtUpxhx88OkEcrViF+4I62rca41O30L8mIP8/qLgDomis5MFf5Bh7Wb9Z+QqgHxPa7t4haUKQfTXoOK12kumrDi+ZZvADlUUJd8QuKwKwlKp8l5HdkuQi+BfTEIPL5nLhXdaBp3uIi3EGjPVh3yrLwzHY4hK46tMi5E3FHf5FiEfRVAcYDR3iuLa4SEEXUsM1Rb2S8dfzTcRsoPNP3zDduBGPmYkQCpyy6CmwbDToUPan7Lk3ZNUoRW/4mNWKdVsjj2diwHlLRBsLvLQ/wL5Wu+EydWJ1lIoKgs0nfA6x+dI0zNeLNhP6/zE0Ft4LRjLmvII2bUEbWOuJx+o1BvsFdjLDrEXhzO8VCoMhrREra7YfAdmEBE9Z8Q0EPNGN8gwXfxZHoAKQe0XnB5VKeTKhHfxOKwuentxqGSUQTCe92R2C3nipYw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b0c0f9-ee61-4b30-4c1e-08d87f6087d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 18:53:04.3957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axiqISjcf4ZflRBREegCbzoAhEiAiegYKRv+rgmexnatq7iK9Tc4AXd/P387iQN2R5i4yvs0uzTI7baTZfGqYP+nhxIo1HQXJ0QKVALpD5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5407
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/11/2020 19:23, Josef Bacik wrote:=0A=
>> +		/* shouldn't have super stripes in sequential zones */=0A=
>> +		if (zoned && nr) {=0A=
>> +			btrfs_err(fs_info,=0A=
>> +				  "Zoned btrfs's block group %llu should not have super blocks",=0A=
>> +				  cache->start);=0A=
>> +			return -EUCLEAN;=0A=
>> +		}=0A=
>> +=0A=
> I'm very confused about this check, namely how you've been able to test w=
ithout =0A=
> it blowing up, which makes me feel like I'm missing something.=0A=
> =0A=
> We _always_ call exclude_super_stripes(), and we're simply looking up the=
 bytenr =0A=
> for that block, which appears to not do anything special for zoned.  This=
 should =0A=
> be looking up and failing whenever it looks for super stripes far enough =
out. =0A=
> How are you not failing here everytime you mount the fs?  Thanks,=0A=
=0A=
Naohiro (or Josef and everyone else as well of cause), please correct me if=
 I'm =0A=
wrong, but on zoned btrfs we're not supporting any RAID type. So the call t=
o =0A=
btrfs_rmap_block() above will return 'nr =3D 0' (as we're always having =0A=
map->num_stripes =3D 1) so this won't evaluate to true.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
