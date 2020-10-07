Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C0028581A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 07:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgJGFWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 01:22:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63779 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJGFWV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602048139; x=1633584139;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7AbG3Ypd+Wsmv6BiC2SKvJ5en7NDGGyJkalc/78jLe8=;
  b=SPH49tUHaMhp/e6QCESE5AkCYVSVfUgV+h9ufvmDHtfdT1iA8JL6wXfQ
   ZhOgq7BvfqmSrC6nHc5+BMCiNrN+unw2ejh5yT96eMx2ifMGFouf9V8dE
   4v1XFefsU2KnXrgGUd1oJcEdQOt3R1S9ce8V3DsEOoHFl81DBCrovDKSM
   jAhKWFTsh2dR5lxO5GhPhEyhHQHY3HpJUxul/N/ALvUsgMG8D1R76HLAv
   ODrHgNWi/6P/dyCMhK7JRu3eegSOF2/XBWbaWyDjt7K/DX2etE5P3mfZ6
   Oba4xKWU1CSX6Cm8zpgvh7S6Vi31lOYl+0Llkwr+8nIB4XEpLuRclWFBS
   A==;
IronPort-SDR: jey4tDS3u/i1Csz25ZVruKxFrSor1yg7ZX4foALu4lJ29UQL1Rcb7HHylBuY+E0/ZB3dMJh3cn
 6nMPJdeERlO3s1wpBCDD3pu7A2xfkbAcD88QC1weawxd0P6eo1OrrKBQOnrLRhDLbWqCqx/tTl
 Q8kAceBBxu+FZ9t/stoF1+VLGRfvbDklTAEaqDSEjcLyrVkseoSe4A04sZLUnqmf+t4cohkoab
 nqROgmvZQcSV4JcSIKm0KFSS/D+UR8yB53r2ZgWeUchtcLlQ1Qy/1hXm+1lncseIN4a9ZyN15R
 3uA=
X-IronPort-AV: E=Sophos;i="5.77,345,1596470400"; 
   d="scan'208";a="149145486"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 13:22:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM5JAoCpked5VjKf3XevtKzCYxtjkXwyWN9OoOXHfSy4lx2I0XazU84BR9t3g7YhQffvL1YQrgTiVMPnf/u5JQ8ON+pXA/NZMV24r9VAATRNaxRnt5l58EpIcv30EEACRru+t56EGVeqXdghFivtv0QGDzIgOxpQwSpWyC2ARZO3RKdRIDKPattQmdkSfzyOA8x9RRrug91A8MFAFs2QAqO9z0cg1K2PDeH50PavJ1S0wVc5jPTOSfhnCCzrVZVN5UnGkrhiGvXdODSAACkaQFGZyYG7Df9cgpFe2B7O6AavNYRlP62z4/xLwhRnhEU5vRepZfk2zuh/3zu+jE3Mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0oxlk06pG8lEBQMRmL9B+S8Pbv711ZKoAETCQtFE8E=;
 b=HYcF1dmHEB+OVO0FShudjHqvr2t+z4AmWLbbEw+NiK+RrwrlvAumBocDuQIxPK9y/VlaMRD5ex9JYEa8WfCclkrU2RO8PKgn6wawhuCfoey8OlTg78ywaW84RbjGubzvPk8HumZFuB8izj+oS+6H0nqyQo9U1g3NgOOLGRgL+iqvUO1guVtttwJBd5Wl0zRJSgmoOQxDgqdEcMnd5eXAqNd+sA2k/aRr0XHg0tAtyk2AQ6lzEJfizUYmUQ2iqo2bZj5eU6fGySGS/aYQCT9tMGuwBdnCGkMjBD5xUwk2WDlhoDI9UU68cdrC5lL8qpAHD02dyivFuyaVmADbaNfRLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0oxlk06pG8lEBQMRmL9B+S8Pbv711ZKoAETCQtFE8E=;
 b=IVSVgsNzwvfE6c0Tdl5kjw1gmXkbmoph46hwvboRpPNptIzJ2aBRz0ynnYTICsljSz0T/0spqaGTqqjUdlR/SoelRfsglk67sqfgscF+Tk87E0ROGVw43JuIdE7KJ9M+VvDj4/7QEd/isTeplxaW19PurIDd3YgnUbiWfZpwaII=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 7 Oct
 2020 05:22:17 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 05:22:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: make maximum zone append size configurable
Thread-Topic: [PATCH] block: make maximum zone append size configurable
Thread-Index: AQHWm+sasNtmaR7+P0yDCraMVO0/aA==
Date:   Wed, 7 Oct 2020 05:22:17 +0000
Message-ID: <SN4PR0401MB359826A04A90E9FCDBF111479B0A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <8fe2e364c4dac89e3ecd1234fab24a690d389038.1601993564.git.johannes.thumshirn@wdc.com>
 <CY4PR04MB375140F36014D95A7AA439A8E70D0@CY4PR04MB3751.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:4025:ad46:30b7:4cee]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09ab1aee-ac20-4d78-6f14-08d86a80f516
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4862BDB5395B1AABE903E0B69B0A0@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLt+rzqF+PsgGmV51SLX3NO+nr4fbWRG97XkTTVoOwYR4CZyoVx4DfzbU2Bm1x2YBP/luOjxaDhl61Vhj64FfcAZh27iVeyIAvluTd+O4eeRkZrDDBkKrLN/TjOgy0a/d+8iWSQHZL+YAxrOjVEgtzgjpcrrzykK9pnvHS3QisoFYCPkX5zeDKS9rVwICcpRjcgQNJa/oUpv43ruabO008+OtXdxfDO2HG1T0qJjDLj3cpUOnTIoFA3voSDBBd6Z73b2NTB2BpXbsQuBUHgWlUQLknPW15HDcCBWli46+jNRPS2nO5EOf6Y+kX9dJ2LfVUKwKcAzRT/TkYJW2E53iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39850400004)(86362001)(91956017)(71200400001)(66446008)(53546011)(76116006)(2906002)(9686003)(64756008)(66556008)(66946007)(66476007)(6506007)(110136005)(33656002)(8676002)(52536014)(4326008)(316002)(186003)(54906003)(55016002)(83380400001)(5660300002)(478600001)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zwpdXes7WcSWnftHDweOknNnLMHTeEku3NkzRE6ufaSWW2FX+JxxQARxkXxfq2egPSCnPFypPXLVNvXENbfOhKO4j86cJxqZ5ACHsUhWbtSEabPQdP2sqtkva/7NMtiRYprNYX61VmTyrXDY4jJ302ZQ5+lsDqpWJjkpNnu+UP2z4F6lr1czwmVzzsLcWkKvs0eFffI5CUf7xJGtcLV2flkrsnMOv03qAdPDzmM12pPbbs3wAcNQzqrYscR22lSBRGORIFNw/jXyU8nQRW6ncmDhPGiwDE6S3DhCiGaJZGIQ3XETH8LcJNtLhvIM1/GRoTPrKE8C8n3pEBEWOhu8TkKHXpKO5fK4rWjObi3i7UpBQs3GR096vsPHOZKA42OfwKm/zXhtTsLmX4FSzexVsaES3o9SOy66C251YM9QaFK4o7XPS5nqfQrOmIg8imo5f/gfgGb3Kw5tmeW0Zqpe5E+zi60hl+2jiGokBjbbkFiEjM8xUbC+VlpfUodkVfCEwBOy5Wu6WjYopXb8WDEhJu19E/X7emZ/RFUIYGVhOTyzgFNWwuzDVk/SOTOdYdhVAmMPqLZ1HRWkjgEaqVk5+H4fGmKhgvcN8x76wHoXzu+JcuGuAKvi8H6WEsVr33MdjgiKlg8UOQrIvklfAguFiDgKNe9rcoAfG0n/H/xBm4MBAHBZxUykXwZYNm5ELSt8CtRpT0/bthPUnuQKh5Zmiw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ab1aee-ac20-4d78-6f14-08d86a80f516
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 05:22:17.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwGHowLyPlhd7aiEmUPDYLf2j84fmzAi76O8W4Y4tD8nXwUHCG8q47lodwu1L/TOmbrMvXJ6RLySqosNa4NXN/FHzNQiZhtrnCuKgHKN1c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2020 01:33, Damien Le Moal wrote:=0A=
[...]=0A=
> Hmmm. That is one more tunable knob, and one that the user/sysadmin may n=
ot=0A=
> consider without knowing that the FS is actually using zone append. E.g. =
btrfs=0A=
> does, f2fs does not. I was thinking of something simpler:=0A=
> =0A=
> * Keep the soft limit zone_append_max_bytes/max_zone_append_sectors as RO=
=0A=
> * Change its value when the generic soft limit max_sectors is changed.=0A=
> =0A=
> Something like this:=0A=
> =0A=
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
> index 7dda709f3ccb..78817d7acb66 100644=0A=
> --- a/block/blk-sysfs.c=0A=
> +++ b/block/blk-sysfs.c=0A=
> @@ -246,6 +246,11 @@ queue_max_sectors_store(struct request_queue *q, con=
st char=0A=
> *page, size_t count)=0A=
>         spin_lock_irq(&q->queue_lock);=0A=
>         q->limits.max_sectors =3D max_sectors_kb << 1;=0A=
>         q->backing_dev_info->io_pages =3D max_sectors_kb >> (PAGE_SHIFT -=
 10);=0A=
> +=0A=
> +       q->limits.max_zone_append_sectors =3D=0A=
> +               min(q->limits.max_sectors,=0A=
> +                   q->limits.max_hw_zone_append_sectors);=0A=
> +=0A=
>         spin_unlock_irq(&q->queue_lock);=0A=
> =0A=
>         return ret;=0A=
> =0A=
> The reasoning is that zone appends are a variation of write commands, and=
 since=0A=
> max_sectors will gate the size of all read and write commands, it should =
also=0A=
> gate the size zone append writes. And that avoids adding yet another tuni=
ng knob=0A=
> for users to get confused about.=0A=
=0A=
True, but my thought was to have two different knobs so an administrator ca=
n fine tune=0A=
the normal write path vs the zone-append path.=0A=
=0A=
But that may indeed be over-engineering.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
