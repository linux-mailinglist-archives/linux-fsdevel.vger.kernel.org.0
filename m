Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A931BDCA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 14:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgD2MtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 08:49:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:21542 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgD2MtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588164542; x=1619700542;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z/7E5b0jtOmQ79cwvaQMxnJmVAH1+256lFrAR0un1pY=;
  b=Tfui/bv0IMh924qoIZRu7/e2nT+eUbFHxmU2/DDIfJWQ7h45GggL599e
   UbZTHECb4Ud3YmH7Yv9BX+POrIurqCKHRWAmXde3TA796Dh8yiDw9Ah61
   O4u3bCLxJSIZym8yEFl5pnueUXw+CWgQJpUUl9DHV5s16Rzv0sCAaNoNY
   K8czfPJgF/c/VdDbhtNkkWBYp6e7pJly+qc+1PKq134dEY0X0qeVjp7EA
   vlXZPUAAAGr3zd51K1fHIZM9uEKKlZ7egjGkGL0+jnINX23l1mB+kZm6X
   SI+oG8TYU2L/fDqP1YdFlFydq4KqwIumpcpvGjM1bPAVVHLp7rJPxzH8y
   g==;
IronPort-SDR: 01oLQTTTVTGLTSIVO7APunes6+RB3rVp4Ib3Y6v07091Sqe7TEJvuMLDNf2nVGjBDO282haH4z
 LWUxHGcoDPuaOcgx9hq5Fw+x1O8UyaDBotBcKYLoeN7rdq+sdsfmTASjVLyOyM6QXpyaEbZYgH
 pkdc8Rjnt4HYyuAyF06VtvYaN4QLYZxZuUZeqonqXkPg5K/48ERAVtNdLwRw5Jmv00r65KqzhC
 uVKtPLyWK7lNXitwxPDhgP9mgpyVwlxBRyxVFhYsAOKV62CqZhGlcz6cvXqnSRbRzsjpidFBob
 /VY=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; 
   d="scan'208";a="136802501"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2020 20:49:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9H9lyAD671BhZzGIFqn5MI8H3APap/MmNGaFwdc4+9l+W7y8QcTJY9P7M8zyiIVoxfS2ny63RnbKZ9TXiAUFTwE7l75Xn9Xv/fu+et4EGPlqqNNCbLmYB/F0E08k8XIdKg0eRvCLqY8ofxHyHO0aG63dFzJX5HrWM/3eh/JcBxGmJnzvXnEt6/RGnlynq91Hl5L+/MMPe/mmTPoP/EeE7Vf4QwCld/VATXoQYe8j/R2A2lcwk+G8kE/0lKy2TSHqBUr5Tx2HoGG9QnM+OIDaN0iE5w/jFOckOqa/lYmwfbXKhFv2bDEgw7F6fOYbogc3TfDS2y3+MKlty2T6YlTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtYk3fIcEpU0JF7T7xmaGWxxKOSAi4RX7e3x88ViAFE=;
 b=QbwlGY6ZE4qXtyjOOU4zrBlA4xoPbTmqkBBOvRFK9OKaVWbEn/I0M7DtB31AqCUVyQ5GdQJIR8RN5IKb1QQG1rSAjj859qJwYSjnXSj39G/GFVosYTXWASurq4PBHU0oHbkRi2GvFFMnTnxdqYWWGrNnoqcSzgWMdo22X8i/M8h75vjQRsNZ0gkAMSOfNBxbbqBM7PuqiLovIFinWO/foHC92ZgM/1KHJs4t9PVQvJ+NWx5vw24AOP5RCjM7HKfRAvls0cLjRoSKqC5i/CCNx6ZKDInPAJ2sZjaKLE6Fzsa7/TEWfy1KRKE5QfZai31akLzIAqguIeiK7M7XlAmwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtYk3fIcEpU0JF7T7xmaGWxxKOSAi4RX7e3x88ViAFE=;
 b=RfLEU54AL+s11zAwxOEkcgQ9DoC2Df1tNGYrc1h/5A+kSuKHjRzo57pA0GvYDaoNM8dwVSpW2QFX3siOYmNrTQMKQsiRttDg3Dsbi7szptIOoM0o8rgvA9Berx0XJOznxAM5QwIngBE88zE1lb9PTQgSfpEolUi5XzbatAyvzvs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3535.namprd04.prod.outlook.com
 (2603:10b6:803:4e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 12:48:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 12:48:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v9 01/11] scsi: free sgtables in case command setup fails
Thread-Topic: [PATCH v9 01/11] scsi: free sgtables in case command setup fails
Thread-Index: AQHWHUpBNmJPItd+Qkus1LkJkvn3cg==
Date:   Wed, 29 Apr 2020 12:48:58 +0000
Message-ID: <SN4PR0401MB3598750864A248E1933DB5949BAD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428104605.8143-1-johannes.thumshirn@wdc.com>
 <20200428104605.8143-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89fe14ca-34d2-4641-0fac-08d7ec3baf73
x-ms-traffictypediagnostic: SN4PR0401MB3535:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB353586AE4169B4DFB995EAAD9BAD0@SN4PR0401MB3535.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(8676002)(966005)(7696005)(9686003)(6506007)(478600001)(8936002)(186003)(316002)(55016002)(26005)(54906003)(7416002)(53546011)(2906002)(5660300002)(66446008)(76116006)(33656002)(91956017)(52536014)(6916009)(66946007)(66556008)(4326008)(66476007)(64756008)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFXOpJxV+kFLpg5HUXye5bkMEPiU9MsxBzQbVHJsfIkag0EBGDYbISswXhDEglVZZKy0/Eh+t7HCvgfm40ZN4QjBV47tyHJVmZeIt8EOhQ2LGVyD6evYpWARsQgbEVoyT08hUMCMj6NYjPbVOJSpnInwg3prSe/yfYTnVACuzcT4KgT7pW0gvPPugMPX7O6Qf/rwPv0lgRS/8g1Y7Jjfl3/bphfD8G+rZAUPYxTCa6YgGRqBUXVxP1l9LmDa4iKBCemU/R0CFQxydgP8XoueyIGFoTi61wN7Oc3O4CA7oXbBfdS7nkKcbHsg9Zd4tMOLWH4Yq8ALBSbGiPXtmLM+Eln5BfjabtMCcwOm/Sk19g1+3E6SpsIHsXsN7Fy/DkKeagx72KKYLBvTqcS6+6KVFS0n5oan8yQSHK9s5v6azCp0JVanGcU49QDetAx1fqc4Y83kScuXQR78cU10NCzJIYeHfkWldxCXD+qY6wxipXzhV+DmEeCopBUMnqc5A8c7n6EgBrNnPerr9bb6bavK3g==
x-ms-exchange-antispam-messagedata: oZqEisyzUeM7Y47ptEa4ZTZ7ee7k8q7yFVPXa4b8VjBIxb2cHpQgJDiHRkhW8dKebN0KkxJhZsnjZDuimXMzVVPLpxvHENf+JkRp+7hfc3fiqCA6fjg3NZHzTmU1HOwvY7PGdUlkh43EmQ55z6EAxWIyVL4MkRT29ED8UyMENL5W6TelVp6f0QH1g6XcVkLfX4aMNBxADqj0+bQOxVckxWLsmX/9ykRfgaEfwW0s8UJ6Fd2WXvNiNmm6FY+Ox13Xsr51x4CX0ZXvN9TqawdtE70aknKHghU9zCAy9O6uOJLJFsgNXTouAiTqWtoARehmjoSb2Cmt9GQZVOi4Fi9sxdecGym+Z4HaXX5Y7htl0SSV+p1ooDUiKSbj9G17CYlcxG07pk4eNQrHPx6Y8CedtLCyrJCIWLYpXM7ys20G18vFc8yuCYcblEwPzdzlL7HrUiafMqqtmxnOmX9HWtU2u1PvVf3fl1NdPtfC245Qob548GiFKzKkMNbpKMMZsAcXVVmApc9rPZzUEuVaPae9Hn801i115Mk+/IJB9aFs+xliUpPGAbiZPF3hV1gjku8Tq3mf2cZH4pc+Vc31xlAze/cnsZUb1+o/Ii1i/VC7NxWdQgZH4OptKFMczyeVlMFkSu0AjO1nn4kVf1wwxzOcKpuzPmzkynYOlid9dRc5k4AMr/j7DYdQw20Ge8dVs4FxStOhlH1yjVoHJQDm+k7ardcISal5RiQdYqXVW+dVkej52r4qv6Dd2IW+6/iaziYYOYbAO5/IwayV53eA7/htIN6rd3rclY4tEm3xL062e2M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fe14ca-34d2-4641-0fac-08d7ec3baf73
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 12:48:58.5364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOGOF5ng2Vyy+X0/L5QHIIFJeX1cPC9hLPWo93nB/TwjMmL8bBsgQAK4LIUhlLpWkdiMUMGWEeX4GYwrSgZfF2mV4rlnJh7+UineVtQBZ84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3535
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/04/2020 12:46, Johannes Thumshirn wrote:=0A=
> In case scsi_setup_fs_cmnd() fails we're not freeing the sgtables=0A=
> allocated by scsi_init_io(), thus we leak the allocated memory.=0A=
> =0A=
> So free the sgtables allocated by scsi_init_io() in case=0A=
> scsi_setup_fs_cmnd() fails.=0A=
> =0A=
> Technically scsi_setup_scsi_cmnd() does not suffer from this problem, as=
=0A=
> it can only fail if scsi_init_io() fails, so it does not have sgtables=0A=
> allocated. But to maintain symmetry and as a measure of defensive=0A=
> programming, free the sgtables on scsi_setup_scsi_cmnd() failure as well.=
=0A=
> scsi_mq_free_sgtables() has safeguards against double-freeing of memory s=
o=0A=
> this is safe to do.=0A=
> =0A=
> While we're at it, rename scsi_mq_free_sgtables() to scsi_free_sgtables()=
.=0A=
> =0A=
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D205595=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Daniel Wagner <dwagner@suse.de>=0A=
> Reviewed-by: Hannes Reinecke <hare@suse.de>=0A=
> ---=0A=
=0A=
Martin, can you maybe pick this one up? It's a bugfix unrelated to this =0A=
series and has 3 Reviews.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
