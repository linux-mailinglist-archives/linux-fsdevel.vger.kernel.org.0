Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872DE325CAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhBZErU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:47:20 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40770 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZErT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314838; x=1645850838;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KN3xKTT7Z++Wau8u0bA2E22wIhWmnCi7GsDbxqSvHMs=;
  b=ZMEqG2eqVUu37vSNgsG/kYMIKGH8BO46RyigcsY31a6I53hQd9Lh0El5
   m4PkdCYOC/A+oKjRKbXwXLTSCAUXQm4V9r2xEi+YP4/RnJsBdm3Zk+9d7
   oZpglInt4Hpv9iEX4EFBBCElfcCQ6F2b4mRjfjGusk/EquDBDtWLucyPs
   qS1JGbW+plLutgQVpAJLHnoe7T2n4o1ZvrRReBtu6QEomEE6MX15pt7vo
   tqe9yizjdQfm2q2lYYuExnNKuKBC/Uj9pKLgo98hwqm033LurU2kUkchX
   M62LoWCt0YcQaGtsGNeH3Nkrp1mFRm3NJWuR5smH4P8kZBpWPVxWgPIUg
   A==;
IronPort-SDR: Lx4IKpl/onCNrdNhj+VC7yHaJxEcCWn10TNIN+xI8IWwW04hEEgE36aRrRw4ghFbLLSIXl5db8
 74/7ycg/y82t5WLqC2PsKJJKskApNG1+lo9XxLjJI/F1njS+y3AOITnT/5XfNpjAmH6DMYlxy7
 J/s0/1+tnThnztbxWwv7q9Hf3JsAXtmFoVfazmaVg/6TB/GVoZYo1ezAUjY0xXbTRisuN0DTLW
 09ZZrUu9chlDtCKCP9LEin4Tt6ppdqKs4NIcvR5UexF7CYw7qpZq74teUzhar+96Qpvkti/trb
 qy8=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="271419549"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:46:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzmyb7C1VeCp8h1mv+dhYwH7d2lTe+O+GsYDU7capXVJHVl/vchffQz4Qb21yRIs21s+57YpDCsBIH13FO1DzTD1XuHsZZV66Y3vyFQ+iHaU0etlnP4d5SE0LsmXNLXxtvyCEXrdi/qI/SomXfRtq+p1AJriJKuLaWZKaJDOUd+Lra7YyWmfd6zyMLa+mOZ7+Mq4WvYYKLXh4J0dCRii5+j9XKU2Wvro3FgJnhry7+GnIL8FEwbiqtTFNhfvlZlPBkp3ed2awGRP+cnLcXlqKLBEa7DrTMKVLpOQTTYgPUmWljSW9C6yXuTSzwvqmVcXJjgI2sbAnxESvuK38ydp5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kugrVMzYv+1TSM2rTKsUjUFAw7jVeUKfDQxDXYOg6M=;
 b=hmeNZ9c1zppjFhVVthWHUBjwj8hVmJVVMnl7SKcCSXdLhFjTrEwtwN2r9HkWUdrZqNL+5Y9wJXGNkBTwxJRBOlMBYhZHJapgEnzrh9LvQDPzktfnYt+rNvG1q8UiKfg47cvzgLiWeEKpRSHNxrqYLO+eof5tnp/WFQvFIudemkKVjjhdOZ30nMcNfVZCFQ1Skb6AakgMS6gk2vOhKd4sZ3fCHnKbVj55wQTky96TXwQAaduQVM+SF8MIhXCdL1PG3+F8e6iSOyUuzN/smbPrGQ9PLXr5eEutMbPj5mpXzVuEmA4fN5p/vGFf3Yrvev5gkX8Oeeauj37K5y/TQRkjiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kugrVMzYv+1TSM2rTKsUjUFAw7jVeUKfDQxDXYOg6M=;
 b=W007wdsj5d7Co4YAjfFV/f2erKbXdlXea1oxV1AcJUeLqB0zDAqNnidwCO1/kk1MF9+iEhkWmtw5Sxca9zWlkyxlzftAAoIIKRIVNsx4IiBmKu01giYcD18mG4tmMSnCHTlumXzWkgt6hGGBkI2yPpE5oC+GWqunFv2QKBZaLqE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4913.namprd04.prod.outlook.com (2603:10b6:208:5e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 26 Feb
 2021 04:46:10 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:46:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 08/39] blktrace: update blk_add_trace_rq()
Thread-Topic: [RFC PATCH 08/39] blktrace: update blk_add_trace_rq()
Thread-Index: AQHXC0Rp2T6UAvcWPEKr55N5lBN5hw==
Date:   Fri, 26 Feb 2021 04:46:10 +0000
Message-ID: <BL0PR04MB651438AE930BC2045805530BE79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-9-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be0e63bf-3abd-4453-0170-08d8da117024
x-ms-traffictypediagnostic: BL0PR04MB4913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB49135B812779991DCB334D08E79D9@BL0PR04MB4913.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2j7593JIMY9anYii1Oe9CSxAEEof3vlV2hg04TkJu7pnTdj+9QKW6PC8jTPQdZcC6nPxyvcuQW8jLgUjbxeswWW6Ykyr1wE+Q7Bvm/ELIvE2OUYQws3xrflu2PKEh3kon/CXTehqNDgrwskrtNxHq9aqhej+ufJcCz3ISAsbNEL4sq0xMehdMIzmPDV4o1VTv4ZykI6c6l4B2/eeefFHyuCfGy0WMaev+hRuJnJF5to+9094bpCBlm1CrpQelxj1PjY/bEhcluX5o/1rL3ZvNh5yvfaolDF+zFdArx1JEFej7Zu5/W/mULFe2q9C++gBgoGcVqInw0Kk8JqFVyq96GGZoYihX0fNKBSIB0H00k2tfzI1q9+3c2iQbj29ZjQbPM9GNGPAdjmWCMzqREUCCgwD7d8BStod0f705DCbAKOkaRMKPLeW2Nc/GZXcBPK0u2VjjJNtvinmipGl63dJW268gFqUQ1yF7q8QAP0isotGftPqwGu4mzHn5hSiusWSPR0kiAq+r07wdv3T2eFqNfvkd1hdQOi5zdezmDLhplxhQXAQrBdE9IoyRdLunaFt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(478600001)(64756008)(7416002)(86362001)(8936002)(66556008)(66946007)(91956017)(15650500001)(76116006)(6506007)(2906002)(8676002)(4326008)(55016002)(54906003)(71200400001)(9686003)(66446008)(186003)(921005)(33656002)(52536014)(53546011)(83380400001)(66476007)(316002)(5660300002)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?E87AClEqZ1OzIu/nU/mKXgRSmo4hXhrWBM89COmjsblao/ML1Y9tZJO2va5h?=
 =?us-ascii?Q?45ev+1jC5JjjZH/cPRPq1wfdMif/lxlDAajzG2G9i8Nwfr6z64tlf61PhFn1?=
 =?us-ascii?Q?ukGCio+ftu2Vebx71kA2VQCyJL0ThqEytR5bT0Et7IXkSDsNM34YXOD4q1s3?=
 =?us-ascii?Q?U0nPRTEF6d+wOqNDiT9XkT0VvH+MYJR+2nivAPRqDCo9VIFdaNsY4hbWkvU+?=
 =?us-ascii?Q?BmHHN7wuh98RC209QBFESy7VJPglrEdYJ5QVWvtcC4QWkygncv+pXDNRLqj1?=
 =?us-ascii?Q?1GEa2AI51bVFQfvnwRZSCNziYOdq4Yyr3Rn9Ny0IWYHdoFPTRiDnnlcP3N/1?=
 =?us-ascii?Q?Q4VAjA4Ay+lRLFXqbkSifFyqf9vhslQiRwyG3wozQdo2xCghRMmHWn1SI4tM?=
 =?us-ascii?Q?gkYjWZk6djcydopy2kQtCZo4mEinTXbMpnHZfSZjP/LSWedtFOoYY9z2NlsX?=
 =?us-ascii?Q?DKDxbFUbo8mHGyVQ2vT3ZGpV3gwqY9hj7XdT/i77J1kU+e134feFSdbey47h?=
 =?us-ascii?Q?uFYAVg7ChJi1hAA+0qXbxzG1NlWBFYUaYpFh5xdBkUSKfLrnGW2MDz5qJQRZ?=
 =?us-ascii?Q?rA9P46Hkr6SHPNcCwTdAbS6ClVW/Jv81H1+m1HRY3z2szMtaF+R8mrLYRZ5L?=
 =?us-ascii?Q?VZOrXPfsc/Vn73g/mJ06zCz142vAJogjWN4QeSCYaOmnD757D0TeREZGcNX3?=
 =?us-ascii?Q?gBoTmdpq7OwzN9vjQGB+PU9Xgk9A4NxdfTmm0WQbog+J3uYwpUoJ/qYVDyK0?=
 =?us-ascii?Q?OIuRJyDEMCFZPFvo2HOeNnSG4n3cYTyjAC3jukHROVOrZw/f3Dr8T4lPOkOU?=
 =?us-ascii?Q?ldeBQE4j897/VbxEUCPGLW8qwQUTlTvm7yZ1LE6XN3Czp58r5r2icBPyBIoO?=
 =?us-ascii?Q?vpqZTQ7a9Z1AQC6Z8ohGNuVfUPeW63gBO57F8RJPb3t44gG2MmflyPMJ0+eG?=
 =?us-ascii?Q?m3LIthe8CGJFCnncbUcm2BstOviBoLG4QGvnDKvcqsJjT46qSAX5jpIElNtl?=
 =?us-ascii?Q?rQ6J6aeYB8P+xeqaWKvYC267XT182VzpAy0lS1RxlZmPXbe263zf5Oar4BUm?=
 =?us-ascii?Q?rcG9fjEbpdxFxHlays2dibcgdwbC6444GPsXGen2hXP80Ju7TM28shGp95Iz?=
 =?us-ascii?Q?4ahvv4IFCwN5ZbMVL19+bJ+36WZBPJWE5WTiHnPAaFLScIMV+b4ybsYVC3+E?=
 =?us-ascii?Q?Mzjf1JpLuiwA7p4CnQQmloFQ+XXpSdDfblxSahBSUFUu+KP7APu6KYJVRtsR?=
 =?us-ascii?Q?OhmOr/0OB9ItU97rGKJmQOzQ0bwhTIlWZ3r4sZWZPCewc+5mQ4NCNXI7lhPr?=
 =?us-ascii?Q?DOThxISCaS7STB42r7SAr3GzWOS3TIRPpeVfgpChF53LzKXUhaEjBVTl3YXN?=
 =?us-ascii?Q?E4UGCwoY6nsv27jdTGNDTPTTTiZP4NkLa3yfZW5CiP+8jEs+6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0e63bf-3abd-4453-0170-08d8da117024
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:46:10.3144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxnD49y3FDvD0N2WA4cNWrYrQBzRA9T0yeYa8THhOvXl/Su/9hFDD779UkLL8lQe0JLFg1A9y94wNmtqweIPDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4913
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:04, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
No commit message.=0A=
=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 30 +++++++++++++++++++++---------=0A=
>  1 file changed, 21 insertions(+), 9 deletions(-)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 1aef55fdefa9..280ad94f99b6 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1099,24 +1099,36 @@ blk_trace_request_get_cgid(struct request *rq)=0A=
>   *=0A=
>   **/=0A=
>  static void blk_add_trace_rq(struct request *rq, int error,=0A=
> -			     unsigned int nr_bytes, u32 what, u64 cgid)=0A=
> +			     unsigned int nr_bytes, u64 what, u64 cgid)=0A=
>  {=0A=
>  	struct blk_trace *bt;=0A=
> +	struct blk_trace_ext *bte;=0A=
>  =0A=
>  	rcu_read_lock();=0A=
>  	bt =3D rcu_dereference(rq->q->blk_trace);=0A=
> -	if (likely(!bt)) {=0A=
> +	bte =3D rcu_dereference(rq->q->blk_trace_ext);=0A=
> +	if (likely(!bt) && likely(!bte)) {=0A=
>  		rcu_read_unlock();=0A=
>  		return;=0A=
>  	}=0A=
>  =0A=
> -	if (blk_rq_is_passthrough(rq))=0A=
> -		what |=3D BLK_TC_ACT(BLK_TC_PC);=0A=
> -	else=0A=
> -		what |=3D BLK_TC_ACT(BLK_TC_FS);=0A=
> -=0A=
> -	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),=0A=
> -			rq->cmd_flags, what, error, 0, NULL, cgid);=0A=
> +	if (bt) {=0A=
> +		if (blk_rq_is_passthrough(rq))=0A=
> +			what |=3D BLK_TC_ACT(BLK_TC_PC);=0A=
> +		else=0A=
> +			what |=3D BLK_TC_ACT(BLK_TC_FS);=0A=
> +		__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes,=0A=
> +				req_op(rq), rq->cmd_flags, (u32)what, error, 0,=0A=
> +				NULL, cgid);=0A=
> +	} else if (bte) {=0A=
> +		if (blk_rq_is_passthrough(rq))=0A=
> +			what |=3D BLK_TC_ACT_EXT(BLK_TC_PC);=0A=
> +		else=0A=
> +			what |=3D BLK_TC_ACT_EXT(BLK_TC_FS);=0A=
> +		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,=0A=
> +				    req_op(rq), rq->cmd_flags, what, error, 0,=0A=
> +				    NULL, cgid, req_get_ioprio(rq));=0A=
> +	}=0A=
=0A=
I fail to see why you cannot reuse __blk_add_trace() with the what argument=
=0A=
changed to a 64bit, exactly like you did for this blk_add_trace_rq() functi=
on.=0A=
=0A=
>  	rcu_read_unlock();=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
