Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09B3294BB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 13:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441942AbgJULSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 07:18:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30656 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441906AbgJULRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603279069; x=1634815069;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=612VfocSPbYrCru6IUO11It67mIhD7soavcX4YW3qNs=;
  b=T/KAz88LOIBUPPtkDddE2eSvlzBtLZAYmks/tpJ1eakFU5sssoYfjxnm
   8Cj/DoBToH8u/EpMzB9ne921/Vvz0V19x1iaFoF5OvNqhibs9+tvkn/fa
   Hv6Pe/Np3v6PIrNDXb7DRmFspFy8MsgwqInFRsh2t2Z5mtC+pQDsPJNOq
   GdIX0G+HcRu8cIWZcYZhVEm6NIeq8uplXFZ1SGhi974Ywd2lPjsnMnlmT
   oYJJW6DOnA2qZxYpQagtVRFyDaLfgN4TuNkINec31raz1nUJVMTtpZhWU
   PqRYpYm3htDgzXuyYfQGMYFCViwdYqdIcqQM0Oxl1tsrM8kvOAtPKOuQ7
   g==;
IronPort-SDR: 1okmr8cOPzV5RcXwTWz0vcz9xPtBcAVHO9AdvSSBgOyWDPQtViDw4o2ln60WdPWSs7f87EJz3e
 0aRQWbtDboqAlBPhJpA76BaQIXJnI8DRc/fQjZafIYUwTdEi1YqcX6VICBy+1MEzPeX4y66dxt
 CzlMKKcQ6VqJGD5DVLtYSKmgifwlghAbmf03pDiD231G4V4gMwVGft2+F3c7dsDO2x2Q3tdEqZ
 N+w4H1tDws13lt9vqgK0z+JI0Rnn77xDh8lTJuUgT03hDKl/35BE+P3vQtKamHOae9+vg0HotB
 o40=
X-IronPort-AV: E=Sophos;i="5.77,401,1596470400"; 
   d="scan'208";a="150432389"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 19:17:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxCmilG6H1+NlCjVSUUvv9YAihHFiz5ihK+y9G3Ue9NvHB/0i3JbrS3ltww/qzlm0MvxHR/kmlhreJS411T4HbJQYrN71Nwh6lMjjsR4m4t4tGMnQ7x5ifxAPygQzGHzCwc3gFnczfHut63B5av70OWzFxireyb2Tm35BB8huFcRwhHR/qSZLZR90h1p12GE9YWP2Dy12T8uEKhIiKNWgGrpV6zTTBPnJHPm6/hg7QtjcxPG8SSJ6kmmpaNuquZv+dHq6DtLavxu0OenJDfKNLk6hpfc5C7coF78h2PckdhVnQI0ixSSsPj2E33QeOQZumAGQZMw1ddCG7aEhp5Qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=612VfocSPbYrCru6IUO11It67mIhD7soavcX4YW3qNs=;
 b=ZfX0hUFi0cbacunG7/RzbqV7ocL7OW+91I2L+kObV7/ygXdE3M0raDDVvf0PbZiiP2bdNyKDQDavrYuFi1+jiQwMo8akIJeWg1CgF2zX2JReFsCYMuavDGvkAM09bEJWsQog0ARhE3OYBi8k1TwifezzFfR50ys5Zn5bDaQLc9J3qBPpVktucsNnyB+BgTkVOJTHpdxu9ZbIU7LtYhBPOVIASVagNVVtGkjUcxwIsoYU8J5nCvmgmnZYZWZUz/CTWdm9qAgR3Y7wW1d8KBbLcV94S+0Vg3ZbrMkLBlgZsyJwiJc3cAODSSHmPSqljZwArWrc5Yw+T8S94o/DsbGmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=612VfocSPbYrCru6IUO11It67mIhD7soavcX4YW3qNs=;
 b=bz9tOWmBG3thyPLrVfuFXfKoIBsmyTZo/HuXt0ogv8wlWOP4NTjtqbEnkamDLCzB4r0ToR4AoJ3lcr+jWd/q+W+I4PzHN8pnxxcpD9jfIpHvvTzMBf8pXqtQ3KgNPnUwVI6A4sXHVnQAdhXoiDNwAPoANbX9dLmCY0+ryPZnDuU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5118.namprd04.prod.outlook.com
 (2603:10b6:805:9a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 11:17:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 11:17:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: UBSAN: shift-out-of-bounds in get_init_ra_size()
Thread-Topic: UBSAN: shift-out-of-bounds in get_init_ra_size()
Thread-Index: AQHWp5jo+FBwU+0LhU2DuGQVCdRitA==
Date:   Wed, 21 Oct 2020 11:17:12 +0000
Message-ID: <SN4PR0401MB359868729CABB5CF646E7D149B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <SN4PR0401MB3598C9C5B4D7ED74E79F28A09B1C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201021111428.GC6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10922b0b-2f11-481a-de0c-08d875b2db93
x-ms-traffictypediagnostic: SN6PR04MB5118:
x-microsoft-antispam-prvs: <SN6PR04MB51188B4104E77CABDABC69149B1C0@SN6PR04MB5118.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPDSdZcJKTOafq7eIeywlzV3LZRhABeisDBlX3YEQdSufQuXnzzeEv25PK7R97Kd6ZlG1r1Pl5ZTfeQs3Qlj0V3jDWmsglfRTPX3RnCJQDdxJFPZdZt8MUjxkpksqlIb0bLpK3JW9mC0Mn+td/zgB/9ECgvzbWoIiRHioiGqYrW8JDM90KiExJJdmcWf3HL2Pqd1GCax0wAjBlG+Yj64ODwVe+AMsmNJtnE971vIgryqGenkVTg2EKHLyJ+z6FeqUtBY7iYAF9q4vIP66sdIAs4P/o1/sxsOVIEh4BhVqYvQCW8GvETjTR5Vls3ChEfP1JCQMpoK3L47NTZwGBneQZOOPEkpGMJyLlQ/jJ2FzustZnJTowp0TNDyrC9tEoarWB1apeHEF5xtq2FSBkH9fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(2906002)(316002)(9686003)(5660300002)(186003)(8676002)(8936002)(52536014)(54906003)(71200400001)(6506007)(26005)(7696005)(4326008)(91956017)(66556008)(6916009)(4744005)(478600001)(33656002)(86362001)(53546011)(66476007)(76116006)(66446008)(55016002)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: m2JiuNzqWLUll0QSI9Fw8TIkm18BUp4iHIA9+mzxLlw1nH4yiGqhMc1fb9TT6Em+20w4P4c3uZVSA0D7nT0FptCf0AmOEVxBj9ff0JnocPVX2COYTK5RU1/SsNB1nrV79UCQxEE+Jf/jBNVDskSe+rQj3HnP2GayMG9FrCLrNOljGKGQs3bgMfRYfgkB2IDgEOYSMOk55FyPVjMhjYvcPcQNhatBOGf9ba3aoox/LXx/w0znVC+aHSiPQugOog5s4scfiCdIWq7nmwZXzwQCCEsIisuE4YVCugjezdqwWobQGe6LcWv96YLfUQl7yNyDIF20QZ98isAJebD7xg97bF8yUgD2pl2KayDTVsyShiTbrTwTlfWNh8Fhgfh5quAp5vV5xEeqSzxthfTHXxEVcnIWgDI9CgY/Dhpa8skinNUxJy9/AAQsK5siv5xlApY0zqeIXo05A9lg1ElSy9XKmbqxw4zS3EuZUhivjG+5sZtM7xosvgptr6nlC57I6uoO72EXrbBba7cG0aANUplqFH20LH9DgVhKyQ2fneEa1YJ6K0FCte8vrXBzU29sVfA1tJ/vL5bkS72LmpudJbA7RFSWSOqHcJ68PhAN6JiYWG+gvcOxyn5+ncPbVjHKZ5bkK3QbMQSd45mvTT+hiLeF8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10922b0b-2f11-481a-de0c-08d875b2db93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 11:17:12.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdYUKfAtNEg+ESTytv6ZxAXixuFhPQbh+3OS5UxNxoOmnuT5UxTUcPSOvfiqQJwqwhMFx2OoENuiZ/WjAHdqp4YZTvCe/Gl1A1ZGwaki0Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/10/2020 13:16, David Sterba wrote:=0A=
> On Wed, Oct 21, 2020 at 10:57:02AM +0000, Johannes Thumshirn wrote:=0A=
>> Hi Willy,=0A=
>>=0A=
>> I've encountered a USBSN [1] splat when running xfstests (hit it with ge=
neric/091)=0A=
>> on the latest iteration of our btrfs-zoned patchset.=0A=
> =0A=
> This first showed up with btrfs' dio-iomap switch=0A=
> (https://github.com/btrfs/fstests/issues/5) so it's not related to the=0A=
> zoned patches.=0A=
> =0A=
=0A=
Ah ok, but it seems to be btrfs specific then (not readahead). So no =0A=
need to bother Willy then.=0A=
=0A=
Thanks=0A=
