Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D8C226C5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgGTQsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 12:48:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45453 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgGTQsx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595263734; x=1626799734;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=X2u88emYH2jNnqrUT9VuY2r7KxlujmVCXnw4hPY6X8c=;
  b=TVA61V+3t+BTA5wF8Bwx9DLA2DizxiyPMgMi2Ei6POwqFrngAIRykEOW
   rgnU1zgzpHAHbPE8b2tPrayWzDnTmewsSAMpWiWqqYdGwJSGAgGS8EKsg
   703GEUfvFeJjApPbe7ZFgxeN3Kl+8QREtib5gwMVr/xLowwcEDjlCsjFL
   Gy9047JqnDl2MfL4SDOcJjuCkvoQTAH0mlfiYpGQ1/frKbyePUBraj31+
   WBYTLzVQboEI3+dlt2oWsF6p0NvWs4sZGqhvFmOgfpsUZVtJjtanHSkEH
   DmBaxRLmHkL53s+TAOnffaE6SaYYVdyXhVAOxoqTHiNCrP6qq/5fRQII6
   w==;
IronPort-SDR: JoUtXj7mBPCY7zUduca9/cDvAgWgMGt3kXR2wYYBWCpNlgV6kt6guemE6MZWdYIEF0XCYcGykI
 SAFjKUpFhiv2iPl6KKbM4WITTgU1xpZZXEa7+ode07+/mRAQUxKCe4ZSufuKNczN1ojhBX8UJZ
 zKYTAGpPVd/CHlAqxyjeyVdmY3trkMO7axbh7SJR5RODSqc+fAvYjQzhzZul8yLdg8j/l3EnBW
 OA5cqBNQL27rrTgQuyu2xnVOkISeoxAfeGeQNfxnyZ/yig7EGa3pabFeZY9U4OyHoQZO+57yp/
 prI=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="144201032"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2020 00:48:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Igi+GIMMJpxEWS5PipWEz8huxEQWDgFaGA4BL1pz31f2bkZeZWbx4uutop3+O2aI0d9pFVOqZ0dZc11qKJAx15U0ZWGRVG7gaS3E9KCKQFlyxi7TtCx3N+eY4yG1K4iRvqXQ5YCXCPaLh+n6d3H7LV2dEOpKj1JyVu7cfu6r8jVu/CtuDrBQVmmsR2XeZg5oLQXDBDMrwoUMKS8KunWBrUFeeCqc1kqb8WdAkUjlbsccOxuSI6eLgBmWvx1vIJbY3RwLfIU0F+LPNh+0tRhD89HM7SbO3awUFZHhW4sDbvCDEAFNY1lgS/7u+s+CQiAY1QPzj+NL+ZPL/eJLGLhoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kzj28V6bsAKkrBhYcM1155tSfOQmd3xmmrXaiILgpeA=;
 b=lVCmNsSmqYQ8WPUbuWGzx7QYAnnmQbkpdIo2F8FXvHB2cNhCL5+CRBy/XPSZZyuTYpA2LGaMyCx2OhCe4lQZn82IUcrQO9N1069pHFS2a+rtzj9tbANog0iWui1rArQHPy1L+4E6Nps5R5aipi14UJWofhq23hRmHAOP9Q+z9a2k1SIopXTgPjuQvSu6sR/LicGLr6ZEW39k61mQnmEN6yKNmmD6jj4QUePOFhc/zt8ek5S1Mtt/ObTA02xJBIASjVmLcf2SX0DHaQpO5+0xx84KugLX4M/Iaf6LsodWgyp0I24Ow+Fkap1vj0hgNYPyg/4DzwqAx162c+8+nJRjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kzj28V6bsAKkrBhYcM1155tSfOQmd3xmmrXaiILgpeA=;
 b=y5rFz5dNqtnRzEZMzRQMHbBJ9UXDsDXBJM9hRwtukCFi3qeetqpDrIfGZ6HCPehPqtexdHrZ8OmzQuWkJ/RV0GERCi5D8YavcJ1MYGcxqFQPr4FL1uYZr/3r+s7K1d83TTTW5zEHU2PBxoO3CoCKSScjWl/rj+oH/R0SqzS0XHs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4157.namprd04.prod.outlook.com
 (2603:10b6:805:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 16:48:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 16:48:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Topic: [PATCH 2/2] zonefs: use zone-append for AIO as well
Thread-Index: AQHWXpitifll0c+NqUqXemZ9Ae0oAA==
Date:   Mon, 20 Jul 2020 16:48:50 +0000
Message-ID: <SN4PR0401MB3598A542AA5BC8218C2A78D19B7B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200720132118.10934-1-johannes.thumshirn@wdc.com>
 <20200720132118.10934-3-johannes.thumshirn@wdc.com>
 <20200720134549.GB3342@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb083499-3dd0-4c34-f5be-08d82cccc7d1
x-ms-traffictypediagnostic: SN6PR04MB4157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4157A7E5E2FE71974B0167BC9B7B0@SN6PR04MB4157.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BiKU1QnKZq62+LCFSO2EZ3cLhW1A9HZB7vV6xgcybZgO0+pYD/7O+wc0l/Dhb/Acd4MgIRubLuF8za8JynGP2/JivLAjvMF/vq4v2Tw099C6lzi0+DrEDsAxARQe+C65kN1Fmfhf3KxINF6/Z4oYXmhU/RQ9FlNYCWqJunyzgvj0KeHp/18nn9ozIpzWjEcqMqoGfSaFuw36qtoLmxHN9Kn4ghfg3ixQEh/FipXjbY2LyZwNLKwPxXA4C4yuAJn4YWvDwTZl1ZQP2nGFYp4h9MTZ5UbdZCd29bSmF4ybNm3KBHzoTtVhutJClvcH+4/FRPmrWCYZc3Ev31cOG72Brg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(4326008)(6916009)(54906003)(478600001)(86362001)(316002)(8936002)(33656002)(64756008)(9686003)(66556008)(66476007)(186003)(53546011)(71200400001)(6506007)(8676002)(66446008)(7696005)(2906002)(26005)(52536014)(66946007)(76116006)(83380400001)(55016002)(5660300002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kbmwPESs3WvhtHTye4pIaJbdJCvaAd/VCRrH4w8yMNtoJrjhAwCOf+JGCdX3nZ2KUZWiyD0L4UqnTngxRC4GqEiiBnqUXjOpxut2bBHpgkMF0GEIqiCPS+/Nmp4sPStFFfQ9iMFgxiNWkQApIp/M/vdwhvwoQdN5Dpjx7KGrbBmKZXO+Wwfc7iAk/H8W7V9hoYl2OVyl89sseh2qHYCJE6Liv+U1O0X+VZeJ75uUwaLXp8/Eg6PTeffRjeWtFLZJAWQ+akEldRxZYhYycvFiDb2tEzfUNPcRDN7Cmf6xEVUMdUqV8p+pInADGQm3t4h8uYWqxmrr9KwUHV2sgEtsNRuFNdCjIBQ1vOkwYRxpujiS5DKQ3VhcEaYHajueUwsgh4sFVwrhXSZzB2EXzbx9azggxTl26NYcIrZA8xmebte2k+vcZxrPXrmrHT0SEvvKg6hIETichYZAXUXaFAhguqO2P2S28gMjWkdzK48BcYxgCLgDfrY2+UkQbVpAQJf7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb083499-3dd0-4c34-f5be-08d82cccc7d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 16:48:50.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KyYAACg6UO0fAKmhQl8apHe8kF/zOi/Rbmx3rMJnQcyDRcwBYM3nXiCGLJsVP+gNlkPNrngdYL34mtXj3FsankqHg0XTxP4XubJqaneQyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4157
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/07/2020 15:45, Christoph Hellwig wrote:=0A=
> On Mon, Jul 20, 2020 at 10:21:18PM +0900, Johannes Thumshirn wrote:=0A=
>> On a successful completion, the position the data is written to is=0A=
>> returned via AIO's res2 field to the calling application.=0A=
> =0A=
> That is a major, and except for this changelog, undocumented ABI=0A=
> change.  We had the whole discussion about reporting append results=0A=
> in a few threads and the issues with that in io_uring.  So let's=0A=
> have that discussion there and don't mix it up with how zonefs=0A=
> writes data.  Without that a lot of the boilerplate code should=0A=
> also go away.=0A=
> =0A=
=0A=
OK maybe I didn't remember correctly, but wasn't this all around =0A=
io_uring and how we'd report the location back for raw block device=0A=
access?=0A=
=0A=
I'll re-read the threads.=0A=
=0A=
>> -	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>> -	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {=0A=
>> +=0A=
>> +	if (ret > 0 || ret =3D=3D -EIOCBQUEUED) {=0A=
>>  		if (ret > 0)=0A=
>>  			count =3D ret;=0A=
>>  		mutex_lock(&zi->i_truncate_mutex);=0A=
> =0A=
> Don't we still need the ZONEFS_ZTYPE_SEQ after updating count, but=0A=
> before updating i_wpoffset?  Also how is this related to the rest=0A=
> of the patch?=0A=
=0A=
This looks like a leftover from development that I forgot to clean up.=0A=
Will be addressing it in the next round.=0A=
=0A=
> =0A=
>> @@ -1580,6 +1666,11 @@ static int zonefs_fill_super(struct super_block *=
sb, void *data, int silent)=0A=
>>  	if (!sb->s_root)=0A=
>>  		goto cleanup;=0A=
>>  =0A=
>> +	sbi->s_dio_done_wq =3D alloc_workqueue("zonefs-dio/%s", WQ_MEM_RECLAIM=
,=0A=
>> +					     0, sb->s_id);=0A=
>> +	if (!sbi->s_dio_done_wq)=0A=
>> +		goto cleanup;=0A=
>> +=0A=
> =0A=
> Can you reuse the sb->s_dio_done_wq pointer, and maybe even the helper=0A=
> to initialize it?=0A=
> =0A=
=0A=
IIRC I had some issues with that and then decided to just roll my own as=0A=
the s_dio_done_wq will be allocated for every IO if I read iomap correctly.=
=0A=
Zonefs on the other hand needs the dio for all file accesses on sequential =
=0A=
files, so creating a dedicated wq didn't seem problematic for me.=0A=
=0A=
