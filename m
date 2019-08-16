Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E6590B91
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 01:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfHPXzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 19:55:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54820 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfHPXzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 19:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565999713; x=1597535713;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oj3bcJTf94IkfV7XUhN1cBI/bwEpJS57PnqE1VUjn9w=;
  b=VBpOSbwSiIwlYAvBq2l/s3pK5D8u/Ah3IogJwtkrJlIvLcReopLTGLYl
   nUfw9Q6P5ulvimB/pwDRQoG7v7WTJvAXbA9idY0pzurTJzfPT4AmI7w0I
   FxiMbQ6Od14MPpQBRlvQE4z8r9TPPCnswhnwPr2GNGk8AEs31UyT/F7L9
   q+TqCTX5Lz2WP5QIr50VUr1/EX7M8IVIXtXLBqSzLm4vq4jP1xSQExISP
   zpqqd4aXDSOm+B+LBUui7m/30XaC6DDv4VvVk5he9Nm5Qe59lPyiBe/ak
   Mgyj18gA9vXOYj2OUdUpc6hHKDOAUaouKSqUMRgdxixRlx1gYypl+qYX5
   w==;
IronPort-SDR: w8vgI9HtyT8YjmDPHuPJLzAenlSobEaEGAiZdAQmi1gcw6Tx8+L6J5L+1b+V1e0iPXSt0wXATM
 MRkCFoW7HtOmoAWAh4Mn5vwSwoJl0v9ORWpVuoT2s8UkxJMnpK90jFCGQ62YYBrFv4WcL+sX3k
 Ht+u8O9sSuEQWgDNaRWJsgUmEIlR/mn/J+XsGqTWh5sof6jiMcSFAhNMd2+HJLycIs8soHay93
 OcgxkNbV45GGTLoM2EGRnnnegyBpxPuI9DrYK4H7QiU/afN5CMCMaWmTHUAaRiCmobpH6XwFE5
 lig=
X-IronPort-AV: E=Sophos;i="5.64,395,1559491200"; 
   d="scan'208";a="216403218"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2019 07:55:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKCaP9P551AHP1kTwbvX4T0dfygqNdBDygxGGAMuy15giCblrmoFR/ixETucg3u9+nHmfo4tF3LF3xoR0FlZyDGuT1eDVfc5HOX16ltPjDq/R/T6bcJjtYoLXv/L7gl2pYN9m3AHRkJY1Z62LuwRUYoK8ISsuak+kJJXsnI/rvpAEx7hpfU40cFd8yXPzzIb/nwwJ7g5d1uksgZeMcIhrbvANIa0bKehHaxQTDb9r92lPlPqp3DvN+NC13DJWuTkFEUa9eyH1GCEq4ssUN2+/jCsjyRFbsJv9K570Se31/cZ/kSg8K5I2cHcmi0CG1DsIz2iIYYja5URZD/vda9aSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqTOlXhtG0i5umPVN0kj4FnuUExvDPRYUm3qWHMZxKQ=;
 b=QPS29zBGFscT8CaNIV7cGHaVuaS658SSYWfGsW3vE7tS38mXSsO3ZgS5tKva+XmO0NxwVqP061qiEz9TQuKWGILXjVRJdHkVsYVNRJ0ie8D7QGXBM5txAOtNvChJLcuoHsc64yQ7SBxyHQlwXKchDT1J/1tt4F1jfGhVykd+SKb7wgEyASTG/wrWotmxEstY+mJc+2K11PwxPSfguaN3znmEx9U8tNQ53h2pQkM4qUwbpcH9afYQ7FJsFg9ybrXfBMDkQJTwMuuiMw9BlzgVBQ2yB+DpqC+E++8GKCZX6clYLxoy/mo1fxZqZdqcHpjUB3ySWxoJOTwXt2lw7YjHMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqTOlXhtG0i5umPVN0kj4FnuUExvDPRYUm3qWHMZxKQ=;
 b=f/Sflk3Dqm0VblpZ6Bsmqh0dygHksn+uXgNi2QUsp8db0mNcHUKYf/FZU+PEUuCJpFbRdr4z9TUKzOrVrey3yNyVcnCrMbqn5E1wHto+gCNBu2k9PSTOgWQ6oMeV06xuAUmTU2QAIjY2iLLnKCCt+yltbT6YZq1V2Y2Q/6loGHI=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5847.namprd04.prod.outlook.com (20.179.59.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Fri, 16 Aug 2019 23:55:09 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 23:55:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 02/27] btrfs: Get zone information of zoned block
 devices
Thread-Topic: [PATCH v3 02/27] btrfs: Get zone information of zoned block
 devices
Thread-Index: AQHVTcwJ3mXpSFAoAke32QrSccXb8g==
Date:   Fri, 16 Aug 2019 23:55:09 +0000
Message-ID: <BYAPR04MB58161B63A9D337AAD18D4E2BE7AF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
 <20190808093038.4163421-3-naohiro.aota@wdc.com>
 <fd5b4006-0413-c63b-9376-8618e5fcb8f0@oracle.com>
 <BYAPR04MB5816442B6CD412BC6925D90AE7AF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <8e523d2c-f945-44bd-e6f2-c38037af2bf2@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [66.201.36.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7c3abb9-e833-4675-5551-08d722a52baa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5847;
x-ms-traffictypediagnostic: BYAPR04MB5847:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB584798DAA0DFD4FE54C9E018E7AF0@BYAPR04MB5847.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(199004)(189003)(43544003)(186003)(71200400001)(81166006)(478600001)(6506007)(2501003)(110136005)(256004)(14444005)(86362001)(7696005)(81156014)(102836004)(7736002)(53546011)(54906003)(53936002)(305945005)(74316002)(25786009)(5660300002)(4326008)(71190400001)(316002)(33656002)(99286004)(6246003)(76176011)(229853002)(66066001)(9686003)(446003)(3846002)(2906002)(6116002)(14454004)(476003)(486006)(8676002)(26005)(66476007)(55016002)(76116006)(6436002)(66946007)(52536014)(64756008)(66556008)(66446008)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5847;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iyhPm4Lhuv/zgeAfTfVxBYHSXQs1pkeXmEpbKP+ZsazWHSjvN3IV+BFXy4lzmuZXAKgj/HDB/aF87XEa9fb7CdGWBZL438VCM8AEasUWRW9/aTxO5qiERRncWtjlPmJjR8/iwjhRXZdEAldDO+3i+KFl8GWvR2xe2FxvIxgCzt9Wopmv4v8j0DOWXafoZlcLX4bbb8GYEOMIVcky/IaJSNTXPh/qW6yLFba/CtRbbB68U/XAtCc6gjTq/xb0Bq0Q/LG14OZW7ub1noAgWa7vDyhwbh03QSZnmwU5Aj+TWTCGo+9j2/8ifcVrtXraN7CZ49vtyJtFac0nRbCl1+xCQ18me09SAflIDzE7dV3cyKr0yI+UU9AR3XO+ve4h/CJZUeEGtuPFFfb8A2y36HpVd470SqG6mQtGekLuCXgxXAY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c3abb9-e833-4675-5551-08d722a52baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 23:55:09.2476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yHgbmGksVl3FLpNr0clOvsvRReJIHpQtafvwfZ7LxfIy/uT5Fxb6D2N3gXTCrgg2u56Yb+N7mFK2xElbW/Bzhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5847
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/16 16:48, Anand Jain wrote:=0A=
[...]=0A=
>>> How many zones do we see in a disk? Not many I presume.=0A=
>>=0A=
>> A 15 TB SMR drive with 256 MB zones (which is a failry common value for =
products=0A=
>> out there) has over 55,000 zones. "Not many" is subjective... I personal=
ly=0A=
>> consider 55000 a large number and that one should take care to write app=
ropriate=0A=
>> code to manage that many objects.=0A=
> =0A=
>   Agree that's pretty large.=0A=
> =0A=
>>> Here the allocation for %zones is inconsistent for each zone, unless=0A=
>>> there is substantial performance benefits, a consistent flow of=0A=
>>> alloc/free is fine as it makes the code easy to read and verify.=0A=
>>=0A=
>> I do not understand your comment here. btrfs_get_dev_zones() will alloca=
te and=0A=
>> fill the zones array with at most BTRFS_REPORT_NR_ZONES zones descriptor=
s on the=0A=
>> first call. On subsequent calls, the same array is reused until informat=
ion on=0A=
>> all zones of the disk is obtained. "the allocation for %zones is inconsi=
stent=0A=
>> for each zone" does not makes much sense. What exactly do you mean ?=0A=
> =0A=
>   btrfs_get_dev_zones() allocates the memory for %zones_ret, and expects=
=0A=
>   its parent function btrfs_get_dev_zone_info() to free, instead can we=
=0A=
>   have alloc and free in the parent function btrfs_get_dev_zone_info().=
=0A=
=0A=
Got it. Yes, we can change that. Thanks.=0A=
=0A=
> =0A=
> Thanks, Anand=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
