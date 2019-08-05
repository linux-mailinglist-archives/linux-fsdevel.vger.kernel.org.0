Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848D1826D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 23:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfHEV15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 17:27:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42279 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfHEV15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565040485; x=1596576485;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eMNh1gT9MWn/zDJlqYC5eANfsBjruhwjvIbuOBC/UHo=;
  b=DoPEv6m6GaDTADlQWe9lIulo7OoFTJARKFkBN3qP6/tR3iyo7as65ki0
   itdC4S16OJ7I+Y7fQVUskcifNrZb62GPJQg1ED+bv3S6nxHl16nuwoHCZ
   0sPzdyXcYXMlk5A0dz0KLV6Y/iu9ZgOpSLAxPOfNGqxOs1xqTENVwkj6A
   GvBo29Bl6phNryUBteLGH86tuubWiSiOt2QPInzrLCgNXZXD+a2SKLdzS
   lnJ4SzmJUDVjdbPEsrPsMw11PPjIsxWbFM/4BOSBm+QVwlzd0yE+ItZc+
   J4jdkciUxFWa9XxsNoD/pF9b0W8mIQR1/MJKC0aUbXhGTXF77jHdD91uC
   w==;
IronPort-SDR: TaD8JvcGdfv132Ak9JGK7wYr92IbBMMUSJyEkWx47T2vZ760WP3SXnssy2Z/q+mBt6gppWAJUh
 RC8S1kmbfy2JrfKYXJoCGwc5FoBoEMs5kB4W7PbvKCPgWKKAfkhnZyQCXPR3+NgFritjVkQfvh
 gfOTdU4/jWf0/xEXrEo4cuNxRa+ndyDXdVercRBldvGni9nZDMvMH3mMfgGrrDn0lQUNCoXpNO
 y75Y7jYStW3XNSu5UycUekFJ3HHrOUfwWEJXjUiq39rK40vIj/RRPDTCKAquv4/+QPTyr5EQUl
 swM=
X-IronPort-AV: E=Sophos;i="5.64,350,1559491200"; 
   d="scan'208";a="215330936"
Received: from mail-dm3nam03lp2053.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.53])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2019 05:28:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXyqqGEPXjWPSHgyJMT+F/6FZIUcXnVXo1tp+LUSRW5fI+b3ew1Cew7kpkJSkAKnzuKpC6sThA62JocnGPjctkjMNq7OA4bQIWOsUbTK5+fm4vrV0GW0Fu4qa46A0fBuInN1a5ZQQR6PObWjahjq0YcbCUd84aA9AG0aqsFKKnCbB3t7Sh+FFOmQe4+nxqCH+p+3Hnv2WXnqOJLy66hQ8VzgiC1JtqgFoF+wkp8Z4MoK0ITdxppsDDENr4Y3THLpiDBbbqkja7fYgi0WRRY0IBm4dnsRFro+z7HrCf1QFd/1COSMYWxOupQVl/sD3jZ4VNlANkqmFyt717T4eX7DiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMNh1gT9MWn/zDJlqYC5eANfsBjruhwjvIbuOBC/UHo=;
 b=LCEWvv4SbI14qPQOTb8BQ7FI/vyqdvd4SdSbmTilRvIEHxGcb/+Br3xzxtbU4n0DAiCbES0i6KOVm0WwnlRGYsETVYmOS+m6zI1XN7YfD84QyxecGAsQ+x2NU1oshdvg1CzqzljDE+dfCkxXKgNVgBupRPel1mTN6Hg4ueDky5pqJKkEm44VjTeENW9sqdn7G03OJ65qNoFSK1r/ouedZBghj17IjntbGvq14Hgwr5/ICzFVeykr18TSNoIHVTuF/0LXOaJq3MIjwrHWMt22VLxWtXvErm4N48jL/4hUfo/kyTtHCsSUU6hGOFzbqBgjfsQo+ljj1LJ9IClXcgC8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMNh1gT9MWn/zDJlqYC5eANfsBjruhwjvIbuOBC/UHo=;
 b=V4f2ekug2MAEKXDl8CpMQXlUKZFY0MXRZUpGX2IdejMj1Ce7x4ExeLkKGPp62bNQJEYSOdsMsvNvoGiTPmV8PKjXbvwOTvIDdTIGp9bKxLOB+LkUlu8YTgK/tqT+XlJ6omGZKXvQU+7EFpQ7gVuEsjZFqTIzXJPFtgxofTAbJjc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4309.namprd04.prod.outlook.com (20.176.251.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Mon, 5 Aug 2019 21:27:55 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 21:27:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: Block device direct read EIO handling broken?
Thread-Topic: Block device direct read EIO handling broken?
Thread-Index: AQHVS7nFgL74Ixb2GU6mfuU8L6+VdQ==
Date:   Mon, 5 Aug 2019 21:27:54 +0000
Message-ID: <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc5e54b9-6756-4f1b-cbdb-08d719ebc76c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4309;
x-ms-traffictypediagnostic: BYAPR04MB4309:
x-microsoft-antispam-prvs: <BYAPR04MB430911A99209AD84411B932FE7DA0@BYAPR04MB4309.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(51444003)(199004)(189003)(8936002)(71190400001)(76116006)(53546011)(14454004)(6436002)(102836004)(33656002)(7736002)(86362001)(76176011)(6506007)(6246003)(53936002)(66446008)(305945005)(6116002)(4744005)(26005)(316002)(7696005)(66946007)(4326008)(256004)(2906002)(71200400001)(99286004)(66476007)(55016002)(66556008)(8676002)(68736007)(486006)(229853002)(110136005)(5660300002)(52536014)(66066001)(54906003)(81156014)(476003)(64756008)(81166006)(3846002)(9686003)(74316002)(186003)(446003)(25786009)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4309;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VN7NTpfLrad4+eBAp+6NPivB3ShwlDO2X+uGu8RmSzgJTP0sW7hanE1govhm2QdWaLX4TQZBAxqf3xe0466mQpdO4uWELydENhUIpcUB52BtjOl2vW1oiZevPiG3tswk7C1PHaiNawoNX2K4lfFJPhRg7mvc01RCmwBUDU4fEVK4HQX0wp7aVfk6Tb86CojVpgglqK9T6iCiR3vay5B3hFDuIbliRT1Kov/TlBkDzAzxhimn8vVjraE767XXzwJqGron9Q/Y2qhbn6KcbAIiZxml826v8jr1gpA2FISczRa1gdbSdeBMtuwsdSU3kGdZJm4dYrCbrf21pxv3wxEd7NN/TxFZvch9eie2W1dpdn+tiQG6nJNOexeRE9scOtwOXSBoJllzw3frZWYDQep1sLcWrkq2nA23Iae05BKdL9Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5e54b9-6756-4f1b-cbdb-08d719ebc76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 21:27:54.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4309
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/06 6:26, Jens Axboe wrote:=0A=
>> In any case, looking again at this code, it looks like there is a=0A=
>> problem with dio->size being incremented early, even for fragments=0A=
>> that get BLK_QC_T_EAGAIN, because dio->size is being used in=0A=
>> blkdev_bio_end_io(). So an incorrect size can be reported to user=0A=
>> space in that case on completion (e.g. large asynchronous no-wait dio=0A=
>> that cannot be issued in one go).=0A=
>>=0A=
>> So maybe something like this ? (completely untested)=0A=
> =0A=
> I think that looks pretty good, I like not double accounting with=0A=
> this_size and dio->size, and we retain the old style ordering for the=0A=
> ret value.=0A=
=0A=
Do you want a proper patch with real testing backup ? I can send that later=
 today.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
