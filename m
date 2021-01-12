Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807252F2CCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbhALK15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:27:57 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25366 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbhALK14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610447275; x=1641983275;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IVGpTN3i0JHGAu4thfA0DtvBO/6byIfWzSZ0MIS9NZ0=;
  b=qLy9zHiQSXvlP9sJxe+RuLViWxhnsWTf+3gaJ3Ze6BYH0lOoStNzUZBw
   6mJQBfcCQ3kNhMFk5xzKay/bkT46dduOiNGcv9xsdL3fmo+fDV+g88G2d
   Krv6RU4I6cKMteFlJ49XDNHpUc3le8aAN5jpJMcJTGIQQ755CP3PRkE2O
   91hNWYbw3Jr2SADZ/RsacCsMbO1OjTgRi7x+tHfFU8paAN1BDzDz+3oaC
   3ChhUdef87G++uT9tIsWviG8Ldgy51Q2JtCxrx6vKDeaoI8jU1HtyHvkS
   8RdeFsbuYXyB3YjiVt9ztj0BUd1zT1QgPXGdhEXof32eCjwAw3j4Fim9a
   Q==;
IronPort-SDR: tZByq8XTWfKWM6mXt16cgxJvoM0sFYprdLyfh7C3wHubVoZNiVXtYBgQR7573mFjM+Dv4mcLXL
 TuP6EANLazNuCgIdDu5P9ExiqF6bQz/2pvH20bAIuJ7sw7DlYT3KUFpHu4VUi5fVT2RSu9EKd/
 8q9hiOJ4khowLoo3TFc2Kosr5oy96tQpYXAKNRfW1djSnLCRx3UMWe9nhDJId0Dc5WZT8U1/cv
 a/PJvBsX/fYgJVdahyH3A5upFUKT1klDNUvQyY4J4pz5URNBShAjpgpATGmn7v4VM+svo0ME69
 ENg=
X-IronPort-AV: E=Sophos;i="5.79,341,1602518400"; 
   d="scan'208";a="161673534"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 18:26:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1ENyO41YHp/a8L4bTn3r1VUhGl/Nqa8pPr/8aMV0IwrHkHn09JmK9w9jr63Ap1TFqrk7u+BWBPVoqsiOE4xPizjd3k5ObXTa5jSwkJDuQDJuNg0V8GznNSiOUBvS7ijb+b4WPdX4gB6EMWL1frtRxGJR58w1DVzKXSLATfFF1RAU/CpcDPsgiSKCxD9VgLh4z306PZZdKvk9k2OV03mGLu2dBa84EdxQeIhl8/2MKSkc1cMKMGUF4kVRKOByPBqzfC5+i+OqGeHCTHnmgLOERnRSjIdSJPO6Kv8g/N49c1ZVB4UzQ+dyvq2mou/r8YJVZAgBnCao3ejem/g9eCcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exmcFf7+WSlYc4M+Pgo6KhGuv2YkGiaLVfA/lotOHQQ=;
 b=PBthPAYflycTmK4pGhvFAuvj8myX+8nN09pN4B1etkPF9pYAjn57ZWj7OCDNZ52aGOlzrzlNRBfAWhvroeGU0AqwBEmGpqam/3D28YPaThJQUGJ8spzsQpPjOhyUxm7O9K7nnTAdy64nUVadcZr9ciTySteKNjUUYda+r/QgY3PQNVFS8qBChLVsh8dzxUdABxj3R+ZX6LFPbbMbVoV47msj16aIvqzBlUPmHYEhu5ZQQco42nPd79Yr+R11Rdia6pzw6wfD2judAivP3YqWP+/8Tkc8xHVK5KZo7nlAp+OZc3mwV1hs4tQD0wfOvV/YTTRE0xIq1wjD1r941Dohow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exmcFf7+WSlYc4M+Pgo6KhGuv2YkGiaLVfA/lotOHQQ=;
 b=dvgKTktali7kQM+FpmKsdGie3mgy0Ulo6iQlcC8KauimrMK8+E8ZgdpLzj0YlbWhSIXvF5nga7AOa4cQw6rezdR9TUO+JCyK6J/V3+JYyM/Xk8ZvZdOL0FCV3EKnvTQHCqxDftbTupKL+tWOwmUgU8s8LLhAzeeslYMk/4EiwY8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2317.namprd04.prod.outlook.com
 (2603:10b6:804:6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Tue, 12 Jan
 2021 10:26:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 10:26:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 00/40] btrfs: zoned block device support
Thread-Topic: [PATCH v11 00/40] btrfs: zoned block device support
Thread-Index: AQHW2BYevkWiUhuir027m8n6NCWCFQ==
Date:   Tue, 12 Jan 2021 10:26:48 +0000
Message-ID: <SN4PR0401MB35989E15509A0D36CBC35B109BAA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1608515994.git.naohiro.aota@wdc.com>
 <20201222133805.GA6778@infradead.org>
 <SN4PR0401MB35987859AE05E238BE2221669BAB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210112102303.GA1104499@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:480d:3d08:9ab6:e110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0671962-7dc7-4b19-4738-08d8b6e491dd
x-ms-traffictypediagnostic: SN2PR04MB2317:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB2317E101E79A396DC400B7159BAA0@SN2PR04MB2317.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 981R+L2RirkqoDUzsE9XBDFUePPFofN5EXsCgtXssYfJANnarZgTDoLg9O1Q5A2lQKclHY699idfzYEfrrdsDyyiB5XRRSpnGMzf3NCjxcDr/KYiMLbi1d8eJcct+nxiZqke9/5OWRZ2xe+Nb1gklEHxtIqNnMFE2TRiAWbl7kyGyIEB0WQPJN4FiKsudGqW5W6qsnPSa+BBQh5fMsrr8IqMWv87c0RojxaURtAEFQy1Zt7gFWAF23rx2jHW0fpVxQGkhMCES1bj4DlA3OLiHAMhRnYHqQrN4lBmWCEREjilsW5qJOwhmP2PZtDhlUpBHOZZwvV//tQuhawraqiUJelmDzAOC48ppCuiKmLQ3uGBBY0Pa1XBCN/5JMYEnoHgy8Av1vYrkmbkHkv4JgLe+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(64756008)(6916009)(8676002)(66946007)(55016002)(7696005)(66476007)(186003)(66556008)(91956017)(71200400001)(66446008)(83380400001)(86362001)(52536014)(54906003)(2906002)(9686003)(6506007)(76116006)(5660300002)(53546011)(33656002)(4744005)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Hv3V1OQ4wZDwO49G5+3itxrKqSMsb5McR6XypLYC3pOt1dIsc3OwPo76iMQJ?=
 =?us-ascii?Q?0xwvaKqHfiWyyJq/r4N2MLg0XXvPVocEWb44ALO2LPOT4G2uty+k07hOjMDr?=
 =?us-ascii?Q?MoatgbaRiUaOZotvE4ehew3k/im4qPSIEtTWQvR8NRR/epC2PyJGi4HmShH4?=
 =?us-ascii?Q?UiRSqr/O5HimLLYFrHFpdkRC8nsVl3uc7Nnk9zRZQvk6aXE2mjxozbAJiXbj?=
 =?us-ascii?Q?aueaMAY0ff5j37dvWeI0L6T1vWlw9i4nD3Pks7oQfyTiFJ/hPzRiBvkS8V3z?=
 =?us-ascii?Q?kgd8/J2TRlIx9pVm9O3OLp74GQSr7bunPjmPM8kdVUMGq9INQuCnmltwK8iS?=
 =?us-ascii?Q?r1nmnDSxiLY6Pu9gbp9sSA5HDLert5aRmOrwYX2Wm49RkSCjitWSJJ4fOFC/?=
 =?us-ascii?Q?LM3doOJ5JURrSEaCCjkgYFVe2uDF7D3N7s6MwgFwwMVxTy3cx309zpUDwkpZ?=
 =?us-ascii?Q?R1CJ39DoqdvhogNik12BC8RA32cZzLaY4LKI/YWzOrviJhkX6XA74YP2EGhg?=
 =?us-ascii?Q?nlRe2N0Cs5V9XiVv+woPD0XWfkRUcN2jmt2z933rw1IHsxK8jgprOwKqFXRe?=
 =?us-ascii?Q?imy90el6qnlqCukWLE24/yBX50q3h73Og0nvKh+clyrYa+pGFvceC7nPmhtI?=
 =?us-ascii?Q?wM4uTiaSDbuFRXXAHhddA6eQGxF50dycZLAxzopUZjPAcqxkwxWnQPmiih/E?=
 =?us-ascii?Q?1D4fJfyZz9+WRddllUzK2eKy2SVBxtfSAiHbR7bO1uODLZ91fX9ZgxHfAYsO?=
 =?us-ascii?Q?pUjjZFbJ1qlrhBrNCvzacC+1VHe/x3GH7mSzzvc9jLWV8t9IkCLhyE8A+VQi?=
 =?us-ascii?Q?RBV9w5djd4bvmp26stvPnH1HyGoTdT4XzqdMofD9Jaqb8LV78+cKt1NPYv62?=
 =?us-ascii?Q?3ZpdlQeSWSUcPaOjX1yADR27kfsZMLvg5i8Ci8bs+ECqElU1UznyAHmqH+vx?=
 =?us-ascii?Q?Tu27Eda3CS9sO3WtmrAWIuSG9wMeD3I1An60J1IA+uhF6VD6IZIUpLxx825W?=
 =?us-ascii?Q?78wvn0f+FicBHS07FCosXRP/nZdw2zhSzG2+Dr1t9sRIQ9/P6dkLykT9do5R?=
 =?us-ascii?Q?0j10nLEf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0671962-7dc7-4b19-4738-08d8b6e491dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 10:26:48.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSb3vpwRhU34L14AtrVP+fYYD8jF7BkQ2MIIrMWpKhZPM5xPYCQxkDWAIJFmhSl01++mFWk1Dt/ewmQwsKSZPD8mKXbMkeZj+j0V23KI4vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2317
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/01/2021 11:23, hch@infradead.org wrote:=0A=
> On Mon, Jan 11, 2021 at 10:17:53AM +0000, Johannes Thumshirn wrote:=0A=
>> On 22/12/2020 14:40, Christoph Hellwig wrote:=0A=
>>> I just did a very quick look, but didn't see anything (based on the=0A=
>>> subjects) that deals with ITER_BVEC direct I/O.  Is the support for tha=
t=0A=
>>> hidden somewhere?=0A=
>>=0A=
>> I couldn't reproduce the problem you reported and asked for a reproducer=
. Probably=0A=
>> the mail got lost somewhere.=0A=
>>=0A=
>> Do you have a reproducer for me that triggers the problem? fio with --io=
engine=3Dio_uring=0A=
>> didn't do the job on my end.=0A=
> =0A=
> I've only found this by auditing the code.  But the reproducer should=0A=
> be io_uring with fixed buffers, alternatively using the nvme target=0A=
> driver with a btrfs file as the backend.=0A=
> =0A=
=0A=
OK, as fio with io_uring didn't trigger, lemme check if I can trigger it wi=
th=0A=
the nvme target code.=0A=
