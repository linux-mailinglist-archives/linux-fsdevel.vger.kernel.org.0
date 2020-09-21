Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFB527298B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgIUPJd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 11:09:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20606 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIUPJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600700972; x=1632236972;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=L0bExCmDFnrd7uLN1hEUXYfAPvW76MYOEMYNR83VYKg=;
  b=oeJPglbfmtut9dZ2e36pZx2hJxi67Ua0n1GCKZzDSnHKaw3FZ2sDRaol
   zSH9qIFUv0noT1Kr2o9zqwEAPkL8RBU9IuQNiHH4iA8gbn1SVxjFx4vzA
   APC1GNrXMsfzNy9T0XZoIjqARpoTA623LZxH80CZoiPWfDsv4Akg1sTcc
   9p2bI1hLufeLINoVsxOHqXt5LmXOSQOniVHnY7A2a2CGwwjPEF1v6nhhg
   N+IuCMBvGW85BFzhhv5aFuDIf5Lyz7Q+F7XxXv/oEDaO+jT7tnkbXMO1v
   LuuwTz9Atf6SG8eOPFGT6ShJY8arByPfR6hmpiQ7hZay10ezaLhoKEzzc
   Q==;
IronPort-SDR: f9juCtmlgtcnujuQi2uVC4p037kAjqFB+AjTa5W2tibvRUTDnqwz8UG4YVXR2dlPNU7A9/PtnB
 1uSv89ME73DTlLbhM6Kjo2ooP/x1x1mw2LQLZOESy2mobq3HKfTApMxCE/x02q9u9AZKAtSudI
 K1+Gu482SPsp62n+oDtSXhxj1yY6OKkBRAdr6AKXxBU0y3SQA6vmqmXzSEqgNNNQlx5TYtUvGe
 lomjUiFljoVv3TQ+HHndzfFhPBLVcaa402P+2j1xapsBSi9XqSWxKwmtK+luM6ehSbkxk4mwEw
 5g4=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="149132389"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 23:09:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1EEsj737wx3PuY5vkOOsZAUh2CtK1qNX94Sge06RIlkO+q7Awu4hbgPl6YhKtfgGenqAHxeY2vFPfsjltq6vhoDtjpOeR4v6Mw5RapOnFRPAp5Z6gLhIa7HjyTY09Au8g6ReZyqs6VzLdubOyWcAOGH3czIP/cSc57TZnDRfEW+WieGD61276mL2zR6Jp9LKrbCTaWPTFe9eZP8o8iGDFvM+JuWyDWubAxvI1Eec6Mw4xdKnr14VBquytqrvS47L+kAPJPNKxmaZR+yDyR7KMxqaAQhoaDuOMSpmAmsNEjnriIioVeKmTXctAOJSsjsRLSVtz014AscGq9C92i8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdsSZkegkAd5lEo8BjAmU4jj2T7trDZmGt81lzPbsf4=;
 b=I7o2XqMODaHiAu8nyDYrhDkSpX8ftVS58XuS3u9yGeJdVIsgpiRLn1/mx6Cwg3i6l0K/L7H/Bs/iMtI8pZ7yWnJ0GDj2q23aig8t2Igw8neT/Z997CoF3JTIBKwZFtywiBzwCrfEQ4fM5dOBbfZ+Emr67KM4rOosNZc+PIR5Ueg4Ggi1fWQTHXZcALlPOW8n7NBYrSJdE8eH0x2LFWvJRtyeutbRH2UmsQ747ZEDAcdHVCki1IIzZt4Y9u+nvlJhTiZtsdmjHvBoJ4bB195m7UAeXruUeNQlNQO60eFRRdUJVDC2qM2zcEsdfu+96mb/Rsngq6tvP81PdTIHOEWacg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdsSZkegkAd5lEo8BjAmU4jj2T7trDZmGt81lzPbsf4=;
 b=N1TiL7pTrVDUR4o0NNbOYsOhOHaEozx/+VCN7Z8Z2fWK/O6nxblsWrO4OtKz5GEfaHP1/Kt+uYM4qxNRM8sdYHkBcDdeOFT1YBQYYei+Susj7KqhB3f6LmPPOL/qK3Sk46iPbgo7fs/w8cbyPNpX8UCljBUHUL55hqfUpBqQrMw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2237.namprd04.prod.outlook.com
 (2603:10b6:804:f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 15:09:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Mon, 21 Sep 2020
 15:09:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "dsterba@suse.com" <dsterba@suse.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/15] iomap: Allow filesystem to call iomap_dio_complete
 without i_rwsem
Thread-Topic: [PATCH 03/15] iomap: Allow filesystem to call iomap_dio_complete
 without i_rwsem
Thread-Index: AQHWkCWve/A6tOmnTkOBZO+DKBgAOw==
Date:   Mon, 21 Sep 2020 15:09:29 +0000
Message-ID: <SN4PR0401MB359847A0A50291840C0C96649B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
 <20200921144353.31319-4-rgoldwyn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb9e7ab3-2a01-489b-d3c2-08d85e405681
x-ms-traffictypediagnostic: SN2PR04MB2237:
x-microsoft-antispam-prvs: <SN2PR04MB223796B0D6372C34814A2FC69B3A0@SN2PR04MB2237.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cxi/K3RAmUup7DxdMjVpGXCPbMBsEUaT1l4ACsjYZ+oh5Ibolny9cTaY3pLKa+ZUrN96aZaoA8ENk78aOcKGckS7L2nNc6K/i7WpWvpWaC0y6IetNRmJu9Vh0A84squwsRzhVvU2FuBkpX3DBHfq5TcpkNL8GMhCJqWEnefoFq7Rm9GY7iouhldmzxGi7q+xMNFhbeJP7Dc2Cov8dMJ1wcYS2GE2i2ZTulrU5NzoDhmnjVWhob1Wwts47EZ26/a+qwj9yzaBmIiLSSLQ9i/Bj48fGGTz8LcUZoL9qHJiClUQ0jGZeg7Z4dZ4TTW0VJbs8OG5UqqiFlABW/4OBhWu9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(33656002)(9686003)(4326008)(83380400001)(55016002)(5660300002)(4744005)(478600001)(52536014)(86362001)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(71200400001)(316002)(53546011)(8676002)(110136005)(186003)(26005)(7696005)(54906003)(8936002)(2906002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TjpTuaMspcmMTIAnwsSkIeje9JTYtlDxmOLiZPS+eWPlqzTQQM1TP6ZTTDnUGYofMnm+qOTbJruJSvipWSiQQ3fgtKH1WDL02e8nMEP3Ofggfu597s6HJz43uYo3uJiRkzQ0eVAS7qPTEEMa5Zl/PYtcGhXILEVg4yct64P5/uJ/KFYgUBEgHgYfM//TnIczHvvsFgnXhr53+wpM2e3TB3vkEycLlzYv2J63+vZOmHT9enTD3X0yrXR+FUhZIMYgErV64JTLVIBze6SDYBqskvZtRyTgNXjpZjgwce7+CoXoknPNPKj5dzJya5cW7mrfovhFqu3qA02HdaswM2EpPmeMIvlOzaKhnZrx7Xv2B+d5Uj7tuf7vsPgEpLH83IoX8c4xh9Mx/NfTsxwCFrQ0igFDRN59sxRJs9zQyBi14cWkmq1M21/NvplgMQrVlC+UsnmO84MPcr5ST0+swOUJ9u64g/Nz8TqwxmUdlsZsp5hvG/uC7vAweamG0ubAB2Fw1637GhD/G0cYkPR9SIliqPW0TzNCxGFsd7oEQweBP6Kvkd1Pex9r1O/GuAZtt7QRXRQ9Kkg+7XqMZ+lWDsjCQwSXOw5hcmZXdknSJflglTCdjag97Uywu+X+pe6uHH6MGy5gniRcIMGV9+1BCpA4Mw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9e7ab3-2a01-489b-d3c2-08d85e405681
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 15:09:29.4092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zsq7DFdXSO/JaJayBe2PMlv1oUHH/8hq8n2kEMRnPb5ou/Yk76lWWSRfR2w6KAOP5u6dpu/BjcT9AYEgm/t5OEotM4Qw/pyn8dDLQTiq6Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2237
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/09/2020 16:44, Goldwyn Rodrigues wrote:=0A=
> From: Christoph Hellwig <hch@lst.de>=0A=
> =0A=
> This is to avoid the deadlock caused in btrfs because of O_DIRECT |=0A=
> O_DSYNC.=0A=
> =0A=
> Filesystems such as btrfs require i_rwsem while performing sync on a=0A=
> file. iomap_dio_rw() is called under i_rw_sem. This leads to a=0A=
> deadlock because of:=0A=
> =0A=
> iomap_dio_complete()=0A=
>   generic_write_sync()=0A=
>     btrfs_sync_file()=0A=
> =0A=
> Separate out iomap_dio_complete() from iomap_dio_rw(), so filesystems=0A=
> can call iomap_dio_complete() after unlocking i_rwsem.=0A=
> =0A=
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>=0A=
>=0A=
=0A=
This is missing Christoph's S-o-b=0A=
