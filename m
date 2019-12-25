Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D122712A66F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 07:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfLYGkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 01:40:32 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:41727 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLYGkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577256031; x=1608792031;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+hFmzIwqSQifXI0avuqxIiOa0Vm6kISz1Cr52u9UYh4=;
  b=CptSbGMvfgL4quBd+pAfvfR7cqcggUge9XUomkiT48qKNFZbKnsjF/J0
   T2pWnIX4987Pzp40QnBPYoNTx/os04EiNkuCl5UzUylPuX3soekuTgBBJ
   iRQyZ7FlSpAkJzDUliSRAUBQ69TY14KlSBmB0Lad83MnXKkS4ABXbq4O3
   yd8NAvtvU4iQZF/2nyjJA5590iqmC2VgN8JhTAKZv/Ik83hm4rjZt0qRU
   BcxIXKmF9h+/AEouMBP4w4xV0vEPPJU2SZMaePFhL22mic1LvwHo0A30C
   fddSij9Dcco1qQJdUEM78G2eD+hSKlj+/X9nrxXe/Thps4c/VQm1HWNbN
   A==;
IronPort-SDR: BfJ7RfwvdQJ8XcKvRA17w6OY8yjMslFx9ZwEcD0RSiKPXs/tE0LJOGiBo9BF5k8MHo23B8KWQU
 wFPMKAKHcCn0b9xPLUzp8pYU+DMmUkzPr1CU8WLLxakzPu8LNArVw4v4nL+6cxdqF2Ix/avBiU
 dOBcGUZ1wfGEXlM4a95BvessUJfWGxGGfQwckUFIBLTAi0p4ISnE3edOSoiy0Afx4lo5Y2Hxus
 SKSh0wEJht99veQGxtqPzqdvhjhc9odl4Fc+o2nCZ48e/3m9NH4Pvhv5CUoMrO1buEmX8uLlT+
 DOU=
X-IronPort-AV: E=Sophos;i="5.69,353,1571673600"; 
   d="scan'208";a="233782101"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2019 14:40:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKT/3pCLpIv6pjSMFxvaE//RmA3GpjFsIXiWvi+na69bWdS5KUdoFdJtxARPmDA1UAmb/mY4O2T4TOCErrW3Z9vAJfDvpBhZNgCfHeItqs3jJqmsynWqg0UEWbjPqGa/pchPIkmWxCK79Sa3hEARJPxs0h/bqtN0cRPh6YOVCxe3xzeJjDQq8Ye9nqkaYZZUKsfdlTUSazfAj7UnZuE1lWqZ6TDDBaFp5KyAmicyO0u3goiAr3occb0xgVhUtFSZt7JR2C+2If5R3J/BCal+OrT5ULZSaVdLQaKWdmKSO29l7Oti21fqIXSdMGW0+QhZO+KhEKF7cpwrkH6m4pdfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hFmzIwqSQifXI0avuqxIiOa0Vm6kISz1Cr52u9UYh4=;
 b=Gg8MARz7/Wt4720GoSB2bitxo7Y/RtVgOmZsla2b8I0WntSXEtFzjlKgKQu/UY3zTF6cabas+TPglLwpEu664H9uLnKIexZGf6AVADozylELRwKX3jd+KSPSF+ED4um017k+30473lLCoHhx9jqO3be9v5VIq+RCq7MDfsHvRAeXmGIQXJ4mQKy6prs8B7akn8E43s9dnMrviEN2c/M0jmGFuI5Wf/2JkdUZcz8mSqluORFTTL/ZAlqDTJf4C5lVIz7qXP+v6xZadR90WcM9t3xpzEKIe8TsgRcuzaUuO3CBHjrXKHG7e5fwwXspYq7sjmLVjhqfTD30BkCpOhUzeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hFmzIwqSQifXI0avuqxIiOa0Vm6kISz1Cr52u9UYh4=;
 b=CxjFcU4iZK+amzbT2cF+XVePh78IRCL1lTeJmsBJEjGhzDG0wgJKTRf3t/c3IW+3uJ7hdkO/fIAdpujGu34TM7AeHLE0NmDfxRd0CknfetCGwnGUpMZuiqe0XQ7etSQPZ1YTBOuFvURr72SqnJtb3Hx54Xw9qQOHdYOA1B2kR0A=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Wed, 25 Dec 2019 06:40:29 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2581.007; Wed, 25 Dec 2019
 06:40:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 2/2] zonefs: Add documentation
Thread-Topic: [PATCH v3 2/2] zonefs: Add documentation
Thread-Index: AQHVuf7Aj/1RgKnKOE6js//cNKXmzQ==
Date:   Wed, 25 Dec 2019 06:40:29 +0000
Message-ID: <BYAPR04MB58167BE64D952F385E3F7146E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-3-damien.lemoal@wdc.com>
 <ac1bd604-0088-2002-f03b-5752425bb530@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e65f9052-404e-4369-517e-08d789055515
x-ms-traffictypediagnostic: BYAPR04MB3782:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3782BE3C71926E3AEEB1C83FE7280@BYAPR04MB3782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(81166006)(478600001)(9686003)(91956017)(33656002)(76116006)(7696005)(6506007)(26005)(53546011)(8936002)(8676002)(81156014)(71200400001)(5660300002)(66946007)(4744005)(86362001)(66446008)(55016002)(186003)(52536014)(4326008)(2906002)(66476007)(66556008)(54906003)(64756008)(110136005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3782;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BM/tJfHg+qYqkt9FLxrZS7R/lTxNAtnoSpvXiF/zyziqs0paUoMGjAogfqhq+Bv10lyRjxhaHFHlfMqEyFZuRQpiiYyMOoMG4t8PRrRDr2WRjou/ocIwk9FsnM/Y7fsQvfpG6Kzx1TA88xoXc38MVPAYka7ItHJD4RKVL8wkwzTogc42EWtDIicDykriYEvFumiwFr8JjOFpn6FFl+7gs0+Lmk87WoNZMlgzYzJps69Wj8xsdV+UkG8I22Ryx10V1aMFUXiips1zj/Eq87eeXlcJKrlw1Uv0Nz0Sv55D7SHY2NIJLPeYx9McJKruUzK+DC29Cf3yHNsKRKRMTb+1yQii1lwL6QZQnezpw8bZJb8PSMcPh4BjZW2WVlz/1/OX3LUFunA1LEGyiDhRf3eTXf7jgyFVa/WNNYZsjrDI98BM+rs+ySKaphqom+ELw3aL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65f9052-404e-4369-517e-08d789055515
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 06:40:29.0737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7L961cvgvVvLX2+d7k4+hwPFUngnT66+F7U7cH7pspdgDKGAdwbAfzxBWCg2H+jiKX6IIgLi++APF3JXEQi/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3782
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/25 10:33, Randy Dunlap wrote:=0A=
[...]=0A=
>> +For sequential write zone files, the file size changes as data is appen=
ded at=0A=
>> +the end of the file, similarly to any regular file system.=0A=
>> +=0A=
>> +# dd if=3D/dev/zero of=3D/mnt/seq/0 bs=3D4096 count=3D1 conv=3Dnotrunc =
oflag=3Ddirect=0A=
>> +1+0 records in=0A=
>> +1+0 records out=0A=
>> +4096 bytes (4.1 kB, 4.0 KiB) copied, 1.05112 s, 3.9 kB/s=0A=
> =0A=
> why so slow?=0A=
> =0A=
>> +=0A=
>> +# ls -l /mnt/seq/0=0A=
>> +-rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/sdh/seq/0=0A=
> =0A=
> I don't understand the "sdh/" here. Please explain for me (not necessaril=
y=0A=
> in the doc file).=0A=
=0A=
The drive I used for generating the example was /dev/sdh and it was in=0A=
fact mounted under /mnt/sdh/ for the test, but I removed "sdh" from the=0A=
pasted commands and results to make things simpler. I forgot to remove=0A=
the drive name on this line. Fixed now.=0A=
=0A=
Thank you for the review.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
