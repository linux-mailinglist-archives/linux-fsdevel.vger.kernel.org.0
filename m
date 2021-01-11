Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3632F0FEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 11:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbhAKKTB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 05:19:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:18072 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbhAKKTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610360579; x=1641896579;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GAc9xWN5PzRDWODZsuGBQDZxD8sbzXunAr3kuUIB6hQ=;
  b=UuCH1uhCcNnmGWOq09WzTlokF4yrXEr7uoXdZpiZFUSdF3tm1+d6FrGs
   05gzRATV3h5ani8tak1HyIOqTairrXpAwtJJgJ+kdeg8sKeYF/fEX/Lf8
   9J/k2UoC3gJCihMDu3CgdyAl+J0jNZ1MoCxv8ySZHqAk9wp2esDYJI1RM
   PS0sumdlLxwf50E9kheHIjA/yPbs84M1xiw46T1QHaFXh3iKbnKkgi0MQ
   kmIvJ6Lj2/LqHaL9HiI5nWPTl0MYkOkENpDUbrR/hmP+yBq2bjc7Ndla+
   6IGUS5DCoQi+D0y07kPYr4a0DVIej+YQjKwfLHCzAkdZelgoAIPzklYT2
   A==;
IronPort-SDR: y9hhaJiGwWAjRiI4yGRQq6UaDhoOqrSI60f1KnPscCw/5SriKKODn9/Wxq8gEooL6bJbgQ7LQw
 4bEySB6AdCgGOS61/Aum2t3z8rwqBUjdZj4h98IGwek9U4OageR+T18euvmbJM9tETjrk3ajdc
 /MvEVS0d2axnH/IO75W4RgHVphoKJ2WxMhX7NCCVni3EIAmCjGD4zmhVXSEMQC65jhuxXgOMfF
 9+0RmN3vsbTVf2s6jihUZ4EhPWEqyKyJa1jQ3ShoXaJyOcvEXZ0tpDxYeS0RDi4kI5k0XKPJr1
 aSU=
X-IronPort-AV: E=Sophos;i="5.79,338,1602518400"; 
   d="scan'208";a="261027452"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2021 18:21:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxOdDy8r4uvn17WmLxEjCA5kIzjlBMi8XfPzpP11li47Nl9pPeRwwssFWkPiNewjUyS1hipjyAa10iF8lwCtYNXYk0TNDyGeYapg6fCmvfItiUVIwJI5FgL6rYMEtQHxGl8C8y+v56wSkuMQctjDph04Y+cbW+nASq/IoE5/Jzq+mG2Zw7FUMUc1kj6e7zhjtkDwsvhV6CH8eSnsJz05rfRkmPkdJPf6JrVBv1tI8B2glPoYr1P+OJI0eXIm3EDkzfRyinEzT26g739fGcYhJpNoVlJniAIseS4FQJtHaWm6UWbagFY1ORDx8bw5so5uevHM2he+WpzLxeDV7RXfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1tMrH3+9NGrEHYFGblHG8yJukFvuSY30KSR6LLT0Vk=;
 b=DFG95uX4R+Fmy1ASqfh+UmFEtxOEeoFTX4smfPB3fq0wI6MJMdWnwzp/cFn0pTqydeFoIRKL5aSN/XCBkeqx6EulBsidsF7u8lSS5DOFvWCgyjoWsq9JEhhi24lOLAAXE3QXckRPM2Xj6Q7rk2nExfjol8ge5gN4KVEj8zapDur9en3JcZ9KE/c5Jjnvvp+m8+04eolXe6l1bC40VNCV27q1IAewyHeoiyC/Iu8Xm9PJ3T4Sgi++BlI5RFCL6p/oGnOeeeJ81J7fsPmgfFSvJzMwBeeCVh3/FpqwNAT7K2+IdZBGcEa9D7MQ2f/8gXBHf3PEsXAsWBCxhM7N9cCBMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1tMrH3+9NGrEHYFGblHG8yJukFvuSY30KSR6LLT0Vk=;
 b=ZH3THHb188fcM6oGYvCgN5Qm+eg7TURGJncKOZG0wr3RmE+CXFv7jMAuk/6AmzgGvJhsZT1M3Dsi8zIgMtex3DuKtew28rjLACGxB57MJPc5zs+sX6gF/6HNZHhJWVahHGDswD5uChfNkX8P7TsD20pcHaGwfEd4R3CqxGHfeN4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4928.namprd04.prod.outlook.com
 (2603:10b6:805:9d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 10:17:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 10:17:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 00/40] btrfs: zoned block device support
Thread-Topic: [PATCH v11 00/40] btrfs: zoned block device support
Thread-Index: AQHW2BYevkWiUhuir027m8n6NCWCFQ==
Date:   Mon, 11 Jan 2021 10:17:53 +0000
Message-ID: <SN4PR0401MB35987859AE05E238BE2221669BAB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1608515994.git.naohiro.aota@wdc.com>
 <20201222133805.GA6778@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:61e7:c51d:aa77:1fcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f46ab58-7d6d-4fc7-5b5e-08d8b61a2825
x-ms-traffictypediagnostic: SN6PR04MB4928:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4928377BAC932A855FB74FBF9BAB0@SN6PR04MB4928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wbmDZrDpnYjwbAMh2Qvx57sfTNpqZDdNYDOiSm+HkT1XgHoC07WGUH6EhEGjL3HEiP1Ieb2jQpx0V1Klfk0R90Kb1ZkWYyRfiDkyFjmhHhim9+v1ScA5yEYyDoHBveB6karTMkOjM143vDlTcGP43LMPZzxqtN3JQI7fG+pGAfw73J0uvXuazq/xOOU1KEjOECO5TrCGWqIpHKCpmhp4+SqWski72Qb9b+hhwODGYFBHRtrxDY76kiMIOlJtkb+iEfg0nI6ct0BhTc1UPPPR51viLm4yxZ4pQEMzu+3uME9/E7GPDu+02M1JtKpjwpL3NkDl7nCOeVJ+LoAYy2BeiVXHRXPA9vdaPAOY6IQ8aYFjdO7uv+cHLAREr3nMT/nl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(2906002)(53546011)(64756008)(8936002)(66476007)(6506007)(478600001)(186003)(66556008)(33656002)(86362001)(7696005)(66946007)(316002)(110136005)(71200400001)(55016002)(9686003)(6636002)(54906003)(4744005)(4326008)(52536014)(8676002)(76116006)(83380400001)(5660300002)(66446008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tXTQLSrNTHjWOLFFV87CsnC8cNs1WE5k0QyoB/lvAgnyoyjyhR7uFuMyglAW?=
 =?us-ascii?Q?ruId8l0I/Pzh1c84RHoSDJJRMn40rd/oL68hpZvLpJscsA+/FOQqrvF+xkjx?=
 =?us-ascii?Q?TzmYRIsPNTs8hTrlVdJl+HbeneVjzn+qtrsG+RSrEix+htqdQbcPI2DQOzeK?=
 =?us-ascii?Q?lFDF5bAJgfdp5P9FgG8exek5/tuPJoM0QhVbun3K0AvpecXdcyRp5QQRx3vx?=
 =?us-ascii?Q?IAeSScqVNEqa2k2ZC/pVvDFa2oISRxwmpIii/3c0cTsej1ebRo64YChCiFG6?=
 =?us-ascii?Q?IBsd3cbFUB9PVCq61zreSH68WTBN5nEE+BOeVU8Vyx3oRdBu1MsokQllla9C?=
 =?us-ascii?Q?asdHHVWROCLkZnZwdsK3zGIHXwpxcQuXPTrK2Itcvd6H2FiuGO0gWhqW7xOD?=
 =?us-ascii?Q?JHkpsibTS8fupe/Xqtk8OUEbXaRFjf44aRPAz7QzSaNEM2mhstgkJFFSb7dd?=
 =?us-ascii?Q?MBpG3qsneKIfq0vgPu//K61zhr5/aXa37QlPkQwG1ku+Zsjj37Jfw8hvGw+l?=
 =?us-ascii?Q?k+g2VmD38mBnOmSdlnw9d72xOxwAtddEp0dyQYKL7hOmwIVZAwdwsKydL75a?=
 =?us-ascii?Q?qRhr30evXjocBwpLhydpnUkCjtTEjQgkCJVQT7Ii/mrfXpN6jTFcA+4XYBty?=
 =?us-ascii?Q?kGkOFi1Et8pVR3lVwnBf1DO6AGNoeil6Pto7TlI+0nA5sugWPKJbTLronefX?=
 =?us-ascii?Q?v3bUhFgfXOzBuWfWuuJteEePIQn2gczYxO5Oo3U4DzVi6FZyEmabsiD2hEXm?=
 =?us-ascii?Q?wCbVou0Fpo3wA8jj8B3R0Y1PAcrvOFfpaWATLHVOoDjM8UgoV1R6vUBPs0Ja?=
 =?us-ascii?Q?ktTqVlyZDFZ6R7cD9DtUJ9vDXjrICRuYbiO1RBPfeUlmelFjCb3TqB9m1/IL?=
 =?us-ascii?Q?/YUbF9EgHWg4SP2USf9uR+JQhekrTyzXw9QlszJqKDaDQ/5T1MpMWxD9YpOQ?=
 =?us-ascii?Q?gEto36Fj5KquIVX2N5nw/UfUDCBzJkEps3XKAfQFT4eAU97pZut8a+y1UurL?=
 =?us-ascii?Q?HKLIB9/M3B3UHpjxw/4jr35jd9QV9MXKoujMRnaJAL1J6ZOv3NySUh85TnDd?=
 =?us-ascii?Q?B9Zk2uzV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f46ab58-7d6d-4fc7-5b5e-08d8b61a2825
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 10:17:53.0757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFhn8/lKQkwsTcBh4opjOWg0xwfPegoL7sgaQ3WrIA3xrz+ssqw4woKDinki8YUVw172eo5d3LB8cw/GPN98bHgsZfrDH9EuNwYSZcxaxTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4928
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/12/2020 14:40, Christoph Hellwig wrote:=0A=
> I just did a very quick look, but didn't see anything (based on the=0A=
> subjects) that deals with ITER_BVEC direct I/O.  Is the support for that=
=0A=
> hidden somewhere?=0A=
=0A=
I couldn't reproduce the problem you reported and asked for a reproducer. P=
robably=0A=
the mail got lost somewhere.=0A=
=0A=
Do you have a reproducer for me that triggers the problem? fio with --ioeng=
ine=3Dio_uring=0A=
didn't do the job on my end.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
