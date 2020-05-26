Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD771E1C86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgEZHu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 03:50:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42506 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgEZHu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 03:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590479456; x=1622015456;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=o8iSm5VPJxoY50hdEj+0t/BaMXOud0i0um9ww33shgg=;
  b=DA7f7xqw0ozhbM8JzFy9w+amvm1kbRjJS4ESlogxrlZypoUUqPoQN7+S
   /q988gZ2eXp4EDuKI5iTevlHTlbsWcuQca4VkWsWcQ8RR1VnD0wBkC6z5
   FwKnsKGznJjBRa+4j/8eULvPASaNQqE+mGhPBO5L0tASlqS8STwhWPb/N
   yUSfBUx4EGH7GLn4uwkOH8w1OMpoOaK0shqXimN6PWM1xlV3EotrqLdtq
   Wb91JJeDz5soRdVrfJWRyp4rywMnP1wQY+/0zQf2kQamlmcs9darV4Vzy
   dcT8J/h2e0bc1zTt/gtJa8edCZVT45W/W5eS0tbAXZHE5qI8F0oDdmYqJ
   w==;
IronPort-SDR: bdsl0NR44mvLMzcU0zBHSqLv2iUkms0zQaZ/CsSNXgKWjyFvpJy8duOGdTBrzMgHwRdA7oyMIn
 /9cq1Yt3GcOazjfeFUW22IsqJgwC+kvd+900gVAOhC1TSKj3y1uTETJwsR+AleZB23TPGefGab
 3kL+uuI8B8+FuWy77NOx95EMpGCdWBrDLnwomq6vcNFuIIQTNqWiK6KATjNxjvrjlwSFt7mO+h
 4bW7Q71d9OZBs2tObVwcdm97ZiWcYL+HiSwdagJiKpQKUFmeKYrvgOaxx7KJorR9nc2JI2SQEz
 grk=
X-IronPort-AV: E=Sophos;i="5.73,436,1583164800"; 
   d="scan'208";a="138829540"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2020 15:50:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4vx1PwP6+KkLyDcL2B7uO5jqK81nRSN7jIgSH443+WFWQrPTCV/k2lPgsQTxLwRhnxdWPRMchOHedvxvTkKognt7Sn5AaLXDBREE+yDb30SFSBV9Bu20xjrAkgvphZbzThO2Ivcz2et53jGcycoK3YhJ9gcBG/zUzstrGEsd6+3JKm5oUNGKLrx3jS8jMaNwD0Bpi0GNRinqs9tvtX0zUpFMlkqEhWvGtfhAbmNSBJaJhz5WaesNGvSHXTRc65OJN2qeJ1V1gusihIr15BaC2nE7jBfjWzFuePCpvRVAA/u7R5U6QmUctI/21rC7scha8gSQ/K0RJPxW7V2tJAGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8iSm5VPJxoY50hdEj+0t/BaMXOud0i0um9ww33shgg=;
 b=OnQku7LJ+E2kcO1slnQTEzdH+29euN62g/mH9wBjCAX90vwd5MJPsfSE+bsDcf1kf7hz0j3UjMsuv9h+Rv4+4RzmKouazH4sGvmWsCnA8Mr2DQHOxg/fyg5vYigCm0jbMi2a/DQMWPQzN3YKUMzrpHUTs6PZcRuOUG/eZ/UG2A1loGQgRzUiaMUpWjvUP+CmXJuA5j4IRnB+5r7/7Get9Qwynanwgn0d40mF7i6TxOA82GhjJU6fU8CAwcdco9dK5QAjdNrniFBhb00i9FPagY5owrIhJHmyO/zQVttvcYTPmA3F90/nCprCVOHhZ23ctZD5PqIVrgz/9RN3UjcDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8iSm5VPJxoY50hdEj+0t/BaMXOud0i0um9ww33shgg=;
 b=t5HjKO5G2hoSpsk/6TwPqYRY8VicIU2N/vi0U91mmI4Va8JmrDvfcz5f0/uDvfUO+gpIFSh8058UJ///zlLipFgkfU5PW0MSVeWMn3TnXvX8TSG5AmhpAM4b7/bLbGG9LqhUGBmCokIC+RVznQify7Xi8on9LsqS4ExjMvrRQ0E=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3696.namprd04.prod.outlook.com
 (2603:10b6:803:48::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 07:50:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 07:50:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 0/3] Add file-system authentication to BTRFS
Thread-Topic: [PATCH v3 0/3] Add file-system authentication to BTRFS
Thread-Index: AQHWKdGB/2P28p4DZEOYp4TPCgjJxQ==
Date:   Tue, 26 May 2020 07:50:53 +0000
Message-ID: <SN4PR0401MB35986E7B3F88F1EB288051A79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200525131040.GS18421@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [46.244.204.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb874fea-133e-4fdf-d6ca-08d801498426
x-ms-traffictypediagnostic: SN4PR0401MB3696:
x-microsoft-antispam-prvs: <SN4PR0401MB3696C1E180727A1908850A549BB00@SN4PR0401MB3696.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSQ2Oq/ErtuA1i/19kzCfWnfazoe7VKywsQ4OeFtj1tHo8t917b3SxBLo5oxLUkJsVrbaS68hRV1USU3nZd/zqzA+qTVZ4Johf3c8zQuVrV8ybTlevz7ANlFw2gLb0r2U3TpiqVSS75zYXilLSNzCpwNqNf6TzSE6FDc+F+3xxX3ZB5K+qplLttrwn8d+6tJ7EuUvgTUAGL+u44CV/ZIag8tFDQc+yKS0P4tKN6QZbYqjG2wNSRUP98BlVCPgsi4Y+APqxJ1cT9MnmnFJcJih1a3iZdGIGGF4V3VWm9Bde8O8uLbEBeu2cIRzTagRx86a1/EQEFa3IdiEDcdXv1q7puE3BrOKkw6HSNf2Dyt+5FlR+ShOiGSbievVVWzuscoVM0TMkav17HcYEk95JKraA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(33656002)(316002)(54906003)(110136005)(71200400001)(8936002)(55016002)(7696005)(66446008)(66476007)(64756008)(66556008)(66946007)(76116006)(478600001)(86362001)(966005)(6506007)(91956017)(5660300002)(52536014)(2906002)(9686003)(4326008)(53546011)(8676002)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LwUXsttAvwueNhtt+zUh3KJw27ygEhT9LK9MdA88jASWvLivkJnt5lpqmwku+ODKjRj2Szk2P/yNrc2/YoYo2SRb5FMDPbpnflsp6oGBDlxi+r0us+ER8E6NpeZqyhZDq3uoMO2OL0PQvlcdK4m//spq5jClsjdn1F3ZIVq3D6ZdZaxRMetbpZgsE8DPZYj+TRN2TnNDnHoGPvXhT9GcsWpjkgKF9qTTLlswA/S4KzIWt6BlvloEKp1PzRJlukTgX53wf+8doDo27xkyvR3bBD26xuDll78QqgGE8YDaOw0yH+60qzao5ebUrbWrW0zYCAIkpckwZ4BiLtcWS7P28W2Nrns2w98aMMUF2+ecC/XqrEcV0kduMzdpOyoNYTtGe9J5t8APXb8dC+laWoCTA2Fe26p0hsKhd1ju24IuXu1N+y7SUTHIAdfXCBj1xdw/DJUT5ul8sLhYDQZ764v/nfiETa4lN2rqZpVvKfR0G8k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb874fea-133e-4fdf-d6ca-08d801498426
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 07:50:53.3074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXsSwoK/if6CLxvqdHloQqPTkRc/+41jMyHn68H7q9QrOP9gqsLHYEIkojrkitMfkMkkoCDseOoUteYlnwZvCAu4zNJEStYlHtSWoudKvGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3696
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 25/05/2020 15:11, David Sterba wrote:=0A=
> On Thu, May 14, 2020 at 11:24:12AM +0200, Johannes Thumshirn wrote:=0A=
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> This series adds file-system authentication to BTRFS. =0A=
>>=0A=
>> Unlike other verified file-system techniques like fs-verity the=0A=
>> authenticated version of BTRFS does not need extra meta-data on disk.=0A=
>>=0A=
>> This works because in BTRFS every on-disk block has a checksum, for meta=
-data=0A=
>> the checksum is in the header of each meta-data item. For data blocks, a=
=0A=
>> separate checksum tree exists, which holds the checksums for each block.=
=0A=
>>=0A=
>> Currently BRTFS supports CRC32C, XXHASH64, SHA256 and Blake2b for checks=
umming=0A=
>> these blocks. This series adds a new checksum algorithm, HMAC(SHA-256), =
which=0A=
>> does need an authentication key. When no, or an incoreect authentication=
 key=0A=
>> is supplied no valid checksum can be generated and a read, fsck or scrub=
=0A=
>> operation would detect invalid or tampered blocks once the file-system i=
s=0A=
>> mounted again with the correct key. =0A=
> =0A=
> As mentioned in the discussion under LWN article, https://lwn.net/Article=
s/818842/=0A=
> ZFS implements split hash where one half is (partial) authenticated hash=
=0A=
> and the other half is a checksum. This allows to have at least some sort=
=0A=
> of verification when the auth key is not available. This applies to the=
=0A=
> fixed size checksum area of metadata blocks, for data we can afford to=0A=
> store both hashes in full.=0A=
> =0A=
> I like this idea, however it brings interesting design decisions, "what=
=0A=
> if" and corner cases:=0A=
> =0A=
> - what hashes to use for the plain checksum, and thus what's the split=0A=
> - what if one hash matches and the other not=0A=
> - increased checksum calculation time due to doubled block read=0A=
> - whether to store the same parital hash+checksum for data too=0A=
> =0A=
> As the authenticated hash is the main usecase, I'd reserve most of the=0A=
> 32 byte buffer to it and use a weak hash for checksum: 24 bytes for HMAC=
=0A=
> and 8 bytes for checksum. As an example: sha256+xxhash or=0A=
> blake2b+xxhash.=0A=
> =0A=
> I'd outright skip crc32c for the checksum so we have only small number=0A=
> of authenticated checksums and avoid too many options, eg.=0A=
> hmac-sha256-crc32c etc. The result will be still 2 authenticated hashes=
=0A=
> with the added checksum hardcoded to xxhash.=0A=
> =0A=
=0A=
Hmm I'm really not a fan of this. We would have to use something like =0A=
sha2-224 to get the room for the 2nd checksum. So we're using a weaker=0A=
hash just so we can add a second checksum. On the other hand you've asked =
=0A=
me to add the known pieces of information into the hashes as a salt to=0A=
"make attacks harder at a small cost".=0A=
