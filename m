Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971C1285E06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 13:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJGLVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 07:21:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41234 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGLVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602069711; x=1633605711;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MX0SpL+f2fyUYmg8eT00mdEXj5tDWBb3RhnjY6WRlsU=;
  b=T547+mLLonzZLK/g9qf7a6HquKMd8OiouJD7BVvy8/Y83lz3thTNgLUy
   Zj0Y+o3GJajfIxvvb32YPVtMh72cXP3LhJ5lOx97UHtuwhTyTx7dJDH3e
   XHzikvt+eylQX2hNew0BA9AAP19UMApENilLQgUa/p73UX1/RH1FrUq2G
   +80v9pHxXbubCK29yFNvM5p/tBsO+LOepSnCL5HzMwHfUz3K1X4n8nqtA
   Ym2c86IFp08rYsamd1Vp/xqeGIa39ZK4vf0NMK1KgW2xhMfr/uRbXYx8U
   8Tpyh375fWtI9cDpIgWzFdrm4xrHpIDjl/xl8z00Qm5O3RgbX9o/Ze4CB
   A==;
IronPort-SDR: fkQpctz0OpW7p0Y5PCu5tbnzCzUFoaWP2XtAd+3AsSZohDZv9dfsvwftq3KpUtbohDhXlicAHG
 GGdoGpd9ukUjm3UHxqywRNdm9P4C99/8ZVsFK+iTJqIcJAzXzTI89p51v3X4Lt/Z0at3RqqUkN
 GrT49vMuBq1KdRXICgH+BpJnWFalCAdTDajKIf+VSt0NHtY8UyyTeHPldwKYz+iqPM/2/JwL07
 11W6yGwO2eKRkHrt/tUwXKibP7913sIzHsp3YrpbZuboazX8Nk5b8oyjbL3FC2xjDCY8rl+nxX
 GII=
X-IronPort-AV: E=Sophos;i="5.77,346,1596470400"; 
   d="scan'208";a="149167114"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 19:21:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvUcLwLNdLOyTVc7r2ksezP6qKdGBruf/rK9rUaGk+qcAkRrq9KCmlJ0cXSpsH/4vZsp65GjhmU/qcLvlbq9k/CxXv/DtgGYrXQ0eWxQond5Hve+EvSdlf4JU3+03W922DIZkZrgI5jNDZgIFLnwtsQklqQcLUYPsL/c3WgvLNqfnSOMZj9nUOUBrEhn7z49GR9zM+q8agg2Qgi49K1swKxv5d4yA1n5jy9/fj30IYQpwvljwnje273xk7mkFCerH0v0TxvJA9A/uox6osouSfKylZv+jlliOgd/wlRiwdZYrIpUfqZUbUoTr5eD6G9PjFmTGRlvRgzolaAXkkPl8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhZpgPFRKCGWQmpPUeyUppL3m/V9qm1K3WgZhdhL78k=;
 b=gJ/FSoRIAIKF/tBYUjGGp0i9544TM08W3hVco6BRz4gFC1uVvb6Zws42gAzI1FANflgI0i7RHGi0wHIouZmQJvWtZFXIZgZ+RF6lcvLQBY2TmQBYDtTwrUT0aEQBIYJ/LTcPOHA7bNySUYbufZkth8I0Hr/YF8mRBQY+77i3WdE1SdTOeB1jQdaEBRnHwJzEoxf6xN54cUh8YZV/cLAJ+vjhi9C7XLTcWzmcLkR2SCq7+EpPOQroezKsrFY+QZrBf+HBA4kMkLneWEviAoPPcZD1gFRVTLnCSiACPBY8Q9oAfXB2I8HDjm/duV0euOj70ysX7px3HriU6oxEniReIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhZpgPFRKCGWQmpPUeyUppL3m/V9qm1K3WgZhdhL78k=;
 b=joT2R2GsRmnhfru7zu8s7A8KGS3yNAuqQN+ggGLZPU+CHVva3Ju4iVR1/qi2PJSoItXPbRDkMfXlBpIIFEx1aW2sXa6uooWS1WFgLM5frPRVbgCVQqbrip9b1VPnqwiq3VHPWoFNFuEUbnaBpYBAtEO5UxwgAyLFrpREEuK3Wbg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 11:21:49 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3433.044; Wed, 7 Oct 2020
 11:21:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: soft limit zone-append sectors as well
Thread-Topic: [PATCH] block: soft limit zone-append sectors as well
Thread-Index: AQHWnIsT+1OISlCeokyW1tKXedDBTw==
Date:   Wed, 7 Oct 2020 11:21:49 +0000
Message-ID: <CY4PR04MB37511DC0794E496045C22609E70A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:6966:9231:e6a:2680]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 952d27d2-f076-479a-1ef1-08d86ab32eec
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0726D8A6D3B9E2803C3D8C76E70A0@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3CpP3c6D4t0wc0FmcxBvqGC686wf67+dpJGNGAK3Fo0PSf624VASqrET8XcOeXHqZn37RSccArxojM951x+H6VVQRFmYWCX+zGomvtfkVSxp+siWwUl5v+C8W6Heq0nFQ0C+klCK3HiFsid2TixlbLQkCdJTnjG0g7WAB2i570ip4QtWAqHktxQC7Voq2BgHg28XTsCxq/5XWFrx91hT55mO61XRJNYwMaRMNUp/Hc6aaJODN/Z2PxpIzrIfKuF9XtgqHbhwI44WWfiZW4NeDhX08nPHsmWl9xVNZBk+lTNai70zObkvTl8TS/jEVTgXPjWcnpIgSregT+QpeMAUcZh8bXMZs7XszYE0Lt3JXXHSMtxqXEySM6g+zllXBwfTtNsoI2IuK5yvF51eqPQBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(110136005)(316002)(54906003)(9686003)(53546011)(186003)(71200400001)(83380400001)(966005)(6506007)(33656002)(4326008)(55016002)(478600001)(2906002)(86362001)(5660300002)(76116006)(91956017)(7696005)(83080400001)(52536014)(8676002)(8936002)(64756008)(66556008)(66476007)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: N0tmx0QbR5Gs4h4B2xAn1nP3kgKOaZUe8yvl+PIvG/HUKYflvi6wOyHU3laCZvw9o9KvYG7XQ+T+YVadow0Pq3iNrZ5yO7Is+PNRmsZ/MUjusCep5q+xonEm0f+nG1b4Bncm8ugvqYgZowYsdKYdoH9rihEf/pKDtZKiIhba73Xk0fqsFQHRjHrSFfLmOc6Vdtk7XcPpGn31qWjIEzdk+YZuI3omWVJlyODchA5FL9ioIx31ynMyWgRtPRxMdZ6MSbpzUnsowvwOGthuTpWCYKEBwyhmcw1QTDW4wf1P4UeXA9tEagIxSfX9Zz20Q948ibvI8vsPM7CuSbJEzjJFqmNY5sce6mcMeRkuFzvps5aUB9fcVP/JseSFSumvzkP8V8wDbuMZEKLFIbzAxDBKDTxs9nVtX4nC8xIgjiE3r0KWi6SWCXFGpelB0ybHAiAL+nivmAhVJKNVfHF0i1G/H4IXSvxt/2n6S6DMLjqDBZVxyC9KGbkksywp8bGeybUeh3Agix7CcqPIuFJ0rizt1WvwPefh9Nc8OcnxX/sUTpX3HU+b4m94X2s9VtFayhXq4E8zQQUt6Tbn6BABhN+d0eeasTO20nxzMWrbwqlb4FtZjAUHo0NdKzliGei+6+vc7aTJm1kME01Zb3R3d7B1vE5xNz8kSK1M2UkD9i9sLEQ10kjqaaVWUZvICXvv13CVo6ByEIfrZ9aTtEf6tLZJug==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 952d27d2-f076-479a-1ef1-08d86ab32eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 11:21:49.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sjlcNdBn7FvtX9IjgjAhz8LoyFAgDgpOwYwv/PeiR0U6w0F5hIxthlhWF+L/DjpSWM3DAujCHm8agNi+L+XtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/07 18:20, Johannes Thumshirn wrote:=0A=
> Martin rightfully noted that for normal filesystem IO we have soft limits=
=0A=
> in place, to prevent them from getting too big and not lead to=0A=
> unpredictable latencies. For zone append we only have the hardware limit=
=0A=
> in place.=0A=
> =0A=
> Cap the max sectors we submit via zone-append to the maximal number of=0A=
> sectors if the second limit is lower.=0A=
> =0A=
> Link: https://lore.kernel.org/linux-btrfs/yq1k0w8g3rw.fsf@ca-mkp.ca.oracl=
e.com=0A=
> Reported-by: Martin K. Petersen <martin.petersen@oracle.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  include/linux/blkdev.h | 5 ++++-=0A=
>  1 file changed, 4 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index cf80e61b4c5e..967cd76f16d4 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -1406,7 +1406,10 @@ static inline unsigned int queue_max_segment_size(=
const struct request_queue *q)=0A=
>  =0A=
>  static inline unsigned int queue_max_zone_append_sectors(const struct re=
quest_queue *q)=0A=
>  {=0A=
> -	return q->limits.max_zone_append_sectors;=0A=
> +=0A=
> +	struct queue_limits *l =3D q->limits;=0A=
> +=0A=
> +	return min(l->max_zone_append_sectors, l->max_sectors);=0A=
>  }=0A=
>  =0A=
>  static inline unsigned queue_logical_block_size(const struct request_que=
ue *q)=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
