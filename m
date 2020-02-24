Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4880116A791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 14:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBXNsw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 08:48:52 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4975 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgBXNsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582552131; x=1614088131;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nzGLxiNk8p0WIw5DglHBmjGYtP3S0f4k0HJst+uCRNY=;
  b=YWJaqHxuXBsb/duRdrCB/krmWj1/gGyvfaqu32nipO20icsKeYG2ESPb
   UAkINPF8hDwMotUH4kO2g5DklE900wEXTGqbbR0MNLnlNEpVYXH3dtXRK
   dUvL4QO5Qw7x+6hyFbRcXFrjYj1zlVWwQLvarrR9zZ4Odla/ALWajnf5X
   50HhmhKJcOqGI9FuSpmFodBNjDzNLAeFHHAw0UwJ7TBSAUY5lV8ryZ1HV
   kf5bfnVq5fpBUH0VCxR+ZPE/NDYjL64+Apqc90SOZou6DNiPKVclRUKkg
   rPiW84oCyA8Uv13THjy8nD8VkL0s5Qz4mcsDm79IsutbyrKpneFuQLmZ2
   w==;
IronPort-SDR: 9wOnfWDvR+Ux9rWMdzPw93ldPa7xNdxkZWUoDiYvWhR0gdJsXkXrBZyRpjhXo153c7lCxIJBu/
 S5Hs2M+XgQBVviqpSc2cPfEX7rBnPk9953A81d6xKGJMNCqdJg8wBWRzqmBnx496RDshJevxBB
 M6bp6ENnSfKcMWZUonTfsxDHNqo40teTxx1Qz8EXbCp8SOGwnSZQXqmgTDhJZbFr3zipWG69Rb
 XWoBUNsnC+SiiMY5pa6yRtlYEkTLiLoUMeMjk9tY2c4OhslVn8CLCtCe5qLN1SZViqknxUpAGw
 9vk=
X-IronPort-AV: E=Sophos;i="5.70,480,1574092800"; 
   d="scan'208";a="134962261"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2020 21:48:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N57kjCoY4w/QUXqtPsCasY9qzjxHHDbXsiDxDnxEILUs3Un9jk7vushMVlQJokAH/+Sqxkw43R6fC6nB3ty3xkfEuLgro29KaEwZXgeaSKGtXRWni103IRcHnzKUHOczVxyGfX3N8PpdqvH22giJfNI+fHxDizsExxaISSD4gsKRuoChYLaLkRzPjFliCNOqbuBVpL+iVdT1JyJ0ZOWQ8Hi1NvC6pPh75uPMYf0p4BE9F3ZYJ2Bfo6dOt/hPVLQ9u57RESG3DBy/hecmy3uBhUNLKaoJl+oCqivnRG2a7hd6l7VuXn3zLLUeu3kyd4GoHN8/rpMmXj4tQW+ZKg3voQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u9vWq6080q04I0/NGQOqwonUpRYq2KAQdDamnkIldk=;
 b=Mg8+23Ny9X8AVna920BlDhir9iPHdR+y4fEOK2OSd88xIb/677zo1B8igwl6UkEqj6z5nOTEwF7Vx5vtAanOQo6V4m4WNjHOidFi3ZDh2zHadtfxi3CGaGb86gJbcqkA450YMF8OxdTNIA/e6QqLOUJQ6+lvneFRiGfb1K3MyLlkDHbreXZgSv2rlEFclnlEbFTY5n1L8ta3K6vVoWdEsvztwHD14IP2SM6Ofsr9W2NTYzu1B3jAvX6Mw75Z9rtqVCY6vTRFFxURAPRZo8wtfRVpfkW7J38Rsu+F77G+MUFvvh3pvCkLTA1Kork6r3oGlkGBK+hCeEpKiq5SAFNwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1u9vWq6080q04I0/NGQOqwonUpRYq2KAQdDamnkIldk=;
 b=sR+GDrlOe5javVFbfcl+VxeDLna5NlCwlVk/HJ1N2Dte1Sz4rh/t2FlWlrCNP5khZDcJGGLRDXMyLsast06wX1xb3Q8mDqtJ7OREnTaOAd8SY6k7PyHgbJLaqjCAct6LOTcwnGdVNsYhWliHVdldZKa0G7hLWWsrLxu9KhLo6jk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (2603:10b6:a03:10e::16)
 by BYAPR04MB4246.namprd04.prod.outlook.com (2603:10b6:a02:f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 13:48:48 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 13:48:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: fix IOCB_NOWAIT handling
Thread-Topic: [PATCH] zonefs: fix IOCB_NOWAIT handling
Thread-Index: AQHV6MRyTqrbolpwWU2eUaag5JD1NA==
Date:   Mon, 24 Feb 2020 13:48:48 +0000
Message-ID: <BYAPR04MB58169F3C3A66DCCEAA35E332E7EC0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200221143723.482323-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bcfb3da8-bdf8-4d70-0e05-08d7b9304667
x-ms-traffictypediagnostic: BYAPR04MB4246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4246B02B286F1CFD239098BBE7EC0@BYAPR04MB4246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(53546011)(6506007)(71200400001)(86362001)(110136005)(8936002)(478600001)(81156014)(8676002)(4326008)(81166006)(6636002)(7696005)(66946007)(76116006)(66556008)(66446008)(64756008)(66476007)(33656002)(26005)(186003)(52536014)(316002)(2906002)(55016002)(9686003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4246;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cNU4dp0tBnl+aCYln+FPH0i8Q8JcKBdNPZ/YpyPhWqPvpk9fnBat8iyaBKYPUvcu1nyBj8AIBq1A3IrzLQ3+B5c0BsiTlWZggPKsPAw4bV5gvdYI74qAJCbFSxjNxSJ/HdXtb7kmNSgrXnLecrulCHw0NYu4lAmkSdslfxYJdlBCpTsuAY7+oWPIHGihdbDkX4Pk3JtCtMuViaREmJhei547hbpFhWHZW9GAOYmtyEz9xNhPS4fVhn3A2weIuwpQj0o2hq8RJKj9LwUmMtbEOF6ywNBz3ro0+Wd5EJPTy0fvHivQjv7lZw/6LSOA9kZucH7zFayEv055kMMQzZ4xgC5QTM1cI4cR0un3/jQ38DEQaejR6karYT7YmSnUkC/KMmfGg+o1KyThwaM0JkwBvfuPYDSX1pBfEUpreupXl4FmRKitmtYoD1Et8CHrgNrT
x-ms-exchange-antispam-messagedata: lSAXun1nnnH4EvS8GDHf0jE46vip4GFiW9Qt7m4CZ30iivP1ZNTZ7m0PVDNr1THq4XSlbtYHgQ9LwS22pyOWNY1hWjYUyXgiidhxj/9Mk4rHFVIFBS8MwxQ7gB1/EB24ucNdqI6Avx/8837fXC9Vug==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfb3da8-bdf8-4d70-0e05-08d7b9304667
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 13:48:48.4543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJSsNW6tVuLG39g8gpSw3mi33kA0q+9WeLvLOnNrCwnt1ZEP8BdkP5zvrOauTnnJ6MYgBSmmP6xU5hanztUcKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4246
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,=0A=
=0A=
On 2020/02/21 23:37, Christoph Hellwig wrote:=0A=
> IOCB_NOWAIT can't just be ignored as it breaks applications expecting=0A=
> it not to block.  Just refuse the operation as applications must handle=
=0A=
> that (e.g. by falling back to a thread pool).=0A=
> =0A=
> Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  fs/zonefs/super.c | 8 ++++----=0A=
>  1 file changed, 4 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 8bc6ef82d693..69aee3dfb660 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -601,13 +601,13 @@ static ssize_t zonefs_file_dio_write(struct kiocb *=
iocb, struct iov_iter *from)=0A=
>  	ssize_t ret;=0A=
>  =0A=
>  	/*=0A=
> -	 * For async direct IOs to sequential zone files, ignore IOCB_NOWAIT=0A=
> +	 * For async direct IOs to sequential zone files, refuse IOCB_NOWAIT=0A=
>  	 * as this can cause write reordering (e.g. the first aio gets EAGAIN=
=0A=
>  	 * on the inode lock but the second goes through but is now unaligned).=
=0A=
>  	 */=0A=
> -	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb)=0A=
> -	    && (iocb->ki_flags & IOCB_NOWAIT))=0A=
> -		iocb->ki_flags &=3D ~IOCB_NOWAIT;=0A=
> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb) &&=0A=
> +	    (iocb->ki_flags & IOCB_NOWAIT))=0A=
> +		return -EOPNOTSUPP;=0A=
>  =0A=
>  	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
>  		if (!inode_trylock(inode))=0A=
> =0A=
=0A=
The main problem with allowing IOCB_NOWAIT is that for an application that =
sends=0A=
multiple write AIOs with a single io_submit(), all write AIOs after one tha=
t is=0A=
failed with -EAGAIN will be failed with -EINVAL (not -EIO !) since they wil=
l=0A=
have an unaligned write offset. I am wondering if that is really a problem =
at=0A=
all since the application can catch the -EAGAIN and -EINVAL, indicating tha=
t the=0A=
write stream was stopped. So maybe it is reasonable to simply allow IOCB_NO=
WAIT ?=0A=
=0A=
Dave did not think it is. I was split on this. Would be happy to hear your=
=0A=
opinion. Another solution I was thinking of is something like the hack belo=
w,=0A=
which may be cleaner and easier for the application to handle as that reduc=
es=0A=
the number of errors for a multi-io io_submit() call with RWF_NOWAIT. To do=
 so,=0A=
this introduces the IOCB_WRITE_FAIL_FAST kiocb flag that is set in=0A=
zonefs_file_dio_write() for a nowait kiocb to a sequential zone file. If th=
is=0A=
function fails (with -EAGAIN or any other error), this flag instruct aio_wr=
ite()=0A=
to return the error for the failed kiocb instead of 0. This error return of=
=0A=
aio_write() then stops the io_submit() loop on the first failed iocb.=0A=
=0A=
=0A=
diff --git a/fs/aio.c b/fs/aio.c=0A=
index 5f3d3d814928..9f01541c8ecc 100644=0A=
--- a/fs/aio.c=0A=
+++ b/fs/aio.c=0A=
@@ -1568,6 +1568,8 @@ static int aio_write(struct kiocb *req, const struct =
iocb=0A=
*iocb,=0A=
 		return ret;=0A=
 	ret =3D rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));=
=0A=
 	if (!ret) {=0A=
+		ssize_t err;=0A=
+=0A=
 		/*=0A=
 		 * Open-code file_start_write here to grab freeze protection,=0A=
 		 * which will be released by another thread in=0A=
@@ -1580,7 +1582,12 @@ static int aio_write(struct kiocb *req, const struct=
 iocb=0A=
*iocb,=0A=
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);=0A=
 		}=0A=
 		req->ki_flags |=3D IOCB_WRITE;=0A=
-		aio_rw_done(req, call_write_iter(file, req, &iter));=0A=
+		err =3D call_write_iter(file, req, &iter);=0A=
+		if (err !=3D -EIOCBQUEUED) {=0A=
+		    aio_rw_done(req, err);=0A=
+		    if ((req->ki_flags & IOCB_WRITE_FAIL_FAST) && err < 0)=0A=
+			    ret =3D err;=0A=
+		}=0A=
 	}=0A=
 	kfree(iovec);=0A=
 	return ret;=0A=
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
index 8bc6ef82d693..0fa098354e38 100644=0A=
--- a/fs/zonefs/super.c=0A=
+++ b/fs/zonefs/super.c=0A=
@@ -601,13 +601,14 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb,=0A=
struct iov_iter *from)=0A=
 	ssize_t ret;=0A=
=0A=
 	/*=0A=
-	 * For async direct IOs to sequential zone files, ignore IOCB_NOWAIT=0A=
-	 * as this can cause write reordering (e.g. the first aio gets EAGAIN=0A=
-	 * on the inode lock but the second goes through but is now unaligned).=
=0A=
+	 * For async direct IOs to sequential zone files, IOCB_NOWAIT can cause=
=0A=
+	 * unaligned writes in case of EAGAIN error or any failure to issue the=
=0A=
+	 * direct IO. So tell vfs to stop io_submit() on the first failure to=0A=
+	 * avoid more failed aios than necessary.=0A=
 	 */=0A=
 	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb)=0A=
 	    && (iocb->ki_flags & IOCB_NOWAIT))=0A=
-		iocb->ki_flags &=3D ~IOCB_NOWAIT;=0A=
+		iocb->ki_flags |=3D IOCB_WRITE_FAIL_FAST;=0A=
=0A=
 	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
 		if (!inode_trylock(inode))=0A=
diff --git a/include/linux/fs.h b/include/linux/fs.h=0A=
index 3cd4fe6b845e..8e7df1cc92e4 100644=0A=
--- a/include/linux/fs.h=0A=
+++ b/include/linux/fs.h=0A=
@@ -314,6 +314,7 @@ enum rw_hint {=0A=
 #define IOCB_SYNC		(1 << 5)=0A=
 #define IOCB_WRITE		(1 << 6)=0A=
 #define IOCB_NOWAIT		(1 << 7)=0A=
+#define IOCB_WRITE_FAIL_FAST	(1 << 8)=0A=
=0A=
 struct kiocb {=0A=
 	struct file		*ki_filp;=0A=
=0A=
=0A=
Of note is that checking the code path for iomap_direct_io(), I noticed tha=
t=0A=
there are at least 2 places places where the code can block: dio allocation=
 with=0A=
GFP_KERNEL and the BIOs allocations for that dio also with GFP_KERNEL. Whil=
e the=0A=
latter may be necessary to avoid partial failures of large direct IOs that =
need=0A=
to be split into multiple BIOs, shouldn't the dio allocation be done with=
=0A=
GFP_NOWAIT when IOMAP_NOWAIT is set ?=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
