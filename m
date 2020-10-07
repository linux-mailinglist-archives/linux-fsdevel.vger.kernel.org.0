Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EB0286115
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgJGOTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 10:19:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgJGOTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602080362; x=1633616362;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bP1V2YRXLs22OB2d57K1hU5vmYfsMcBh72oWRrDIUmM=;
  b=efO53mfuH0GPBRm4OqS1OlCJgGBXAm3TPOFxCk90/Uo9AwYEjkSnvihF
   r74XOAF06nhXXMtyrUN+gcHWP6QClH+rA1ediEtmxLNLgL3NXDJQCErcm
   Lcm/FQbEVuhOgPD7TLKM+u/GUQBck/JvDzNcCz2sGE4l0ZGQkgOxNpXhE
   dFUugf8zBajg6P+9cnghseA8DWC6SU9EadF8JNNH8rUx3KEhVccGOfJCH
   9A4wPtvAhhxd2A8DuqThh6ta8VuzJfN6CI/jRIiBopLDulW+swDyXs3WC
   /csr6CACdO6LK7bvnhaUp5t3aKNhz42NRCrdOhrDpqIDpJDV9DU8wok5u
   g==;
IronPort-SDR: 9Wiqrp3BT9DYdMuleioXzHj4S0z6N1F32lrpMS79dMQYqQWALCXFEh4djc3s4jtKAs4DRzyb5I
 APjiuORp+Lh6kBejnHQJuWLvRKem3VUUmgzGaroYQjkuOUJ9bNvMqhCJ8iGdrbnya2UosOZYVI
 epooiGh4KFs6wW0IPQYLCwTOLx9sXZRPIElmjgCp5+zPGTaguW7LsfVHiOmbPywPkAiqjNF966
 FM+laf/0LaFwdWQD9g+3FZW0fUaa4frfgIIskfmFlTUPEZW/loMlAG498vtxx3CcOH22EFfVVS
 k4o=
X-IronPort-AV: E=Sophos;i="5.77,347,1596470400"; 
   d="scan'208";a="149177669"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 22:19:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCwv3eWbAGL7XCVW8N/lIrRcPMRs5cvfiPXbZJmjHd3FJE2/zckLWUMmHLEVcerptpAL2ZjntjEyvy6whbToNza8DJA88ArGb+1X4UwTpmFedlhVcX0Rh093fAXDO+3hEEx5WCMZfbSSUIx9F0PO3CI8MurlHmRL/AGLp95ia2lL7EkAnvd05Zep0O2IC8uZU5Hho0cXmKBmKy09NOENqtW71QwwzNrQuw1Y/gP8AWzhKzFcTv5qGYk7STMkqag4JDALRukWjj0T9yB0Tr9naeRboQEzSIqI6dZewpqnajtRj5XyTW2uHHC3DdYhPkwpc+3F1word3bBpRxo3C+2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP1V2YRXLs22OB2d57K1hU5vmYfsMcBh72oWRrDIUmM=;
 b=LFYraQxsbZj5ygN4bipKfpieezNl56I1hxTJkZcm0aqbzoJYls5sYI6BHyGZBuB1STZEkMRmdqZdY4PvWKYFHBO419mfXkI4K+ZQW6foziME679jRAIHK4NM77JcWrQOFjonsNgkWd5JJG3Z4rN+hNZESmj5bzFvjTv/v6R+AVR+tv+psUs6qV3tsF85W1MPweozGtXDP1IX8OZkkVBgXiMTd3vJk4Ps7yw8m2qsZKQWR2sEE8thZ2RixiKOj92nHbex+6rKxZ9rqa6s0ko9ui2Q5rU5KOt0pPap1LFkdaoYjfJBzBbKG2uJ9Ho0bW3AroCAGU+yp5qHVjX1PxwTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP1V2YRXLs22OB2d57K1hU5vmYfsMcBh72oWRrDIUmM=;
 b=moU73/e/FjLSBzFE2H+RIexk3d2HqKzW890FkDkXHT3RoFUUWZy6qivR0bqP6fkt/DGTqiLjKBhismupcrk3R5RLDAsIhv6f1G8NSan3Wjuw5/vPe5lLhXmxzEnQcyzM2S/1e2a5cAeEUBGuWhMkBZmOyAFy65h+LIzwZQrmPlo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3885.namprd04.prod.outlook.com
 (2603:10b6:805:48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 14:19:17 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 14:19:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: soft limit zone-append sectors as well
Thread-Topic: [PATCH] block: soft limit zone-append sectors as well
Thread-Index: AQHWnIsT4YZR0LScLUiFnh8wH9QslA==
Date:   Wed, 7 Oct 2020 14:19:17 +0000
Message-ID: <SN4PR0401MB359845933138BBAFFA287DEB9B0A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
 <a04275e3-48e9-a2e7-c28e-8fce0827a06e@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:d469:2a91:d2e8:8338]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 937625e4-7a97-4981-95ae-08d86acbf9f5
x-ms-traffictypediagnostic: SN6PR04MB3885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB388567A0C6441C773C1DB3CB9B0A0@SN6PR04MB3885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iX3SDhDHxgb79z2WzXsV1dUmAEw/gNkX8AKdpHS6WTa+R+2Ed1fLyDTkDpWBh56Q1ASl3G3JrXHTT794QETf9A/7JyhgfIRbyfPP8pYZ2+d6iT37MyTCOacn74peEqcM3ZCeKo8H/FmfOMXLtGSSFk0gQn7mNkg674nuABXqrgleuqbTi/TwjBOmtdNmoDdWVahOHBcOnwXxGj3Cx5vm9ppiXjfF6gl+7eEpNRWtPoH8zEH9oBdXnDivdzyIPOWzaggb9Z01gjPnEDEeAMwM+R4etbZ3L8dUoyi4W29NOlyUUV+TsrHFjszoRX7m6BnS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(91956017)(33656002)(83380400001)(66556008)(2906002)(6506007)(76116006)(66476007)(66446008)(66946007)(71200400001)(5660300002)(64756008)(86362001)(53546011)(186003)(4744005)(52536014)(316002)(55016002)(478600001)(9686003)(6916009)(54906003)(8936002)(8676002)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xIbw4fW0AktaWmFwgHc8LSKBZFCDNkUP9Bmxs07QhFvo9KgzOydSFlV1ExX/zaFakSgg5EsFtJn+ill54eNn34JTTJ+vTzQz7bHl+m5WoBfjTR+wA5yJ6EPxwlpslwhKTAcjuQDEt3ciSCF3OQVTINFyLeNA9v1AVBspjxGNlqHuMhs4KGPvJKZeWSbu43tbhhyS53RIpjmawk2748PEHl7gauNTnKgXScbr2f5Ri72DU5Ft8kZigPBFjgIuk7/SeCQ+VuJACAIaKtuUAc+8QknQS7RiIH5q15UJeImIiJOWGPR6IFPp5vpbxCee7bwBsbMBjNIq7lfEFwBQH/d5W3RyebIeMQnUBA8BrdwEY5t4E5EG099HcxoN36wQ20UcmL1ktw42JzGWrN1zI3fM5WMHFigenBu1vlMccElQbDkaDuh/aT2B41FHrdM53xdibLFzchUY4Oetc31/7tsuuYZgBjj68K1lDOjkf3uA9lUIvqgDPGRzE0h1t/n2yGRxtNMAOM0kfiNszZjiNgRLVh00pCm3vC0RNOXn2fo+Q+Tp/R459jyea1H9EN/ikx7GUUaMidRiCsxGmoa3vJcwgAyq2KaoKbLX4br6Hki1JEb5CvfY206jrabuskGfOh1ONwWVDq3iyKX0B+Hx3e1iT5ZRGR89+M8gPWcr4EiBxHpCGpVxB+KXcHkFQOBJ9btyB2LWT/Z6f0kuynumfkXQ0w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937625e4-7a97-4981-95ae-08d86acbf9f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 14:19:17.5912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkFtfHu9uFyYn/rwp98se2CoMw+eiigJTNDd8lBdeL4tvLeWua0DfIaWjgUof1v/imNY9tGz8elM82PjnzfuVmq4MRxk9FAYc8eCXPnVZPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3885
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2020 15:58, Jens Axboe wrote:=0A=
> As the test robot points out, this won't even compile... How much=0A=
> testing did you do with this?=0A=
> =0A=
=0A=
Please see the v2 and my answer on Martin's mail, I forgot to commit --amen=
d =0A=
the fix before sending.=0A=
=0A=
As for testing it passed the zonefs testsuite on a null_blk device with a d=
efault of 127=0A=
max sectors and a run with a limit of 64 sectors.=0A=
