Return-Path: <linux-fsdevel+bounces-1203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6726A7D7304
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 20:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E761C20E41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0131580;
	Wed, 25 Oct 2023 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="s4p5F2e3";
	dkim=pass (1024-bit key) header.d=fraunhofer.onmicrosoft.com header.i=@fraunhofer.onmicrosoft.com header.b="YeVDgUth"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738158473;
	Wed, 25 Oct 2023 18:11:54 +0000 (UTC)
Received: from mail-edgeDD24.fraunhofer.de (mail-edgedd24.fraunhofer.de [IPv6:2a03:db80:1504:d267::25:24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A69D;
	Wed, 25 Oct 2023 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1698257510; x=1729793510;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qyM4+f/qKTMIR4Say8iUcu8AwGDD9n4DYy9HGbz3xSQ=;
  b=s4p5F2e3Zp9RWK3EqeiRxslkS2aHYCs+paXXBu+2vScLpWfgylbUD01w
   oTh1Se5pJZW/QS15qjghHonmXWNUzAboI+337L3375SbLFzO72BpUCXWU
   Hl92UD6c9xhO3ljhf+fXL9GyG74lKilmKWUqF9OEF6XURq6suqFRoYJ3P
   XZFtNb4Ue4U0jOmKLWhqqebGazqQQw+MlGnRlTD6WlM0rohfd3u3x1+E9
   vXaDkwzD1SsAAGfsauBKiAWd5u429ThGYUQr6AcI/xvsiXshdOI9hfaU/
   F/u61HLKaMuC/pL6VBAs1m6lij0+2o5aiT5Z0QSpyw/xfDURYxHchpCmH
   g==;
X-CSE-ConnectionGUID: 877il9sTQ9yPuvxt4wtjMQ==
X-CSE-MsgGUID: 178s28cmSxC1NeAN1rTOAg==
Authentication-Results: mail-edgeDD24.fraunhofer.de; dkim=pass (signature verified) header.i=@fraunhofer.onmicrosoft.com
X-IPAS-Result: =?us-ascii?q?A2H7AwA3WTll/x0BYJlaHgEBCxIMQIFEC4I5eoFdA4RQk?=
 =?us-ascii?q?TEtA5MLiUaBLIElA00JDwEBAQEBAQEBAQcBAS4NCQQBAQMEhH8ChxonNQgOA?=
 =?us-ascii?q?QIBAwEBAQEDAgMBAQEBAQEBAgEBBgEBAQEBAQYGAoEZhS85DYQAgR4BAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAg0oVAEBAQMBIg8BDQEBNwEPCxgCAiYCAigKJQYNAQUCAQGCe?=
 =?us-ascii?q?gGCKgMxFAazd3qBMoEBggkBAQawHxiBIIEeCQkBgRAug1yELgGFOYRNgk+BP?=
 =?us-ascii?q?A6CdT6CYQSBRi2DRoJog3WFPAcygUlZgy8pjBJeIwVCcBsDBwOBAxArBwQtG?=
 =?us-ascii?q?wcGCRYYFSUGUQQtJAkTEj4EgWeBUQqBAz8PDhGCQiICBzY2GUuCWwkVDDVNd?=
 =?us-ascii?q?hAqBBQXgREEagUaFR43ERIXDQMIdh0CESM8AwUDBDQKFQ0LIQVXA0QGSgsDA?=
 =?us-ascii?q?hoFAwMEgTYFDR4CEBoGDScDAxlNAhAUAzsDAwYDCzEDMFdHDFkDbB82CTwLB?=
 =?us-ascii?q?AwfAhseDSsWBA4DGSsdQAIBC209NQkLG0QCJ51EbYJOGQc9UQEpAQEESQNfI?=
 =?us-ascii?q?gkjBSockk8uDIMJAa55B4IxgV6MAY0bh3IGDwQvhVeRVJJPLpgOi3CBdZR5M?=
 =?us-ascii?q?4UXAgQCBAUCDgiBZAGCFDM+T4JnCQlAGQ+OIDiDQIUUimd0AgEKLgIHAQoBA?=
 =?us-ascii?q?QMJgjmEFIR+AQE?=
IronPort-PHdr: A9a23:Ml9VthZJ4zy74ePB2YjMhZr/LTF/0YqcDmcuAucPlecXIeyqqo75N
 QnE5fw30QGaFY6O8f9Agvrbv+f6VGgJ8ZuN4xVgOJAZWQUMlMMWmAItGoiCD0j6J+TtdCs0A
 IJJU1o2t2ruKkVRFc3iYEeI53Oo5CMUGhLxOBAwIeLwG4XIiN+w2fz38JrWMGAqzDroT6l1K
 UeapBnc5PILi4lvIbpj7xbSuXJHdqF36TFDIlSPkhDgo/uh5JMx1gV1lrcf+tRbUKL8LZR9a
 IcdISQtM2kz68CujhTFQQaVz1c3UmgdkUktYUDP7ETmQszasA/Tms94wziwO8bnEfNpZm2gr
 I4xdBj1uh0nCmIp1mCUh9ZsleF+9UHExVR1lr/ZXq2aCeZ+VPngc/8AeDdHWdp0SglkLp7/d
 bNQMc45Fr4JjovZhGY8iBadQiv0OsnN9Tp5jUTUhoo8ysZ+MTme5xUKQfY1tErNnOjSNLUAS
 su1l/PM9xebN+J93BPw0pjXUhN+s7KdZ+8hScjp2WAkTzzgp1edhNb1Ozix8+0Tsy/K3vZZb
 LOghWw59B5aqGei2eke0IuWhqRF0FTty3p/7psyOcORaWFGQIv3WIsVtjudMZNxWN9nWWxzp
 SImn6UPooXoFMBr4JEuxhqaZvCIfqSkuE6lWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
X-Talos-CUID: =?us-ascii?q?9a23=3AbnFIQ2qUtKs5KjwQcgnYgP7mUZB6LXzZnWzsGh6?=
 =?us-ascii?q?pMXt3WKHJVkOS3Zoxxg=3D=3D?=
X-Talos-MUID: 9a23:99Mv5wSRsHXt+ggaRXS122F5bpdj5p++IxkrnLwg4tO4EgV/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="71388872"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeDD24.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 20:11:45 +0200
IronPort-SDR: 65395a5f_lKztuUVkyTgUaK94BKWMuWNNcuITOwyGXaOo1RtRGCJ3muK
 /VJYmbYlTpY2mxvrqmd2tICir3vAamHxwcNj/Gg==
X-IPAS-Result: =?us-ascii?q?A0D+BwC7WDll/3+zYZlaHgEBCxIMQAkcgR8LgWdSBz41W?=
 =?us-ascii?q?IEFA4RPg00BAYUthkABgXQtAzgBklKJRoEsgSUDVg8BAwEBAQEBBwEBLg0JB?=
 =?us-ascii?q?AEBhQYChxcCJzUIDgECAQECAQEBAQMCAwEBAQEBAQMBAQUBAQECAQEGBIEKE?=
 =?us-ascii?q?4VoDYZNAQEBAwEREQ8BDQEBFCMBDwsYAgImAgIoCgceBg0BBQIBAR6CXAGCK?=
 =?us-ascii?q?gMxAgEBEAaoCgGBQAKKKHqBMoEBggkBAQYEBLAXGIEggR4JCQGBEC6DXIQuA?=
 =?us-ascii?q?YU5hE2CT4E8DoJ1PoJhBIFGg3OCaIN1hTwHMoFJWYMvKYwSXiMFQnAbAwcDg?=
 =?us-ascii?q?QMQKwcELRsHBgkWGBUlBlEELSQJExI+BIFngVEKgQM/Dw4RgkIiAgc2NhlLg?=
 =?us-ascii?q?lsJFQw1TXYQKgQUF4ERBGoFGhUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFV?=
 =?us-ascii?q?wNEBkoLAwIaBQMDBIE2BQ0eAhAaBg0nAwMZTQIQFAM7AwMGAwsxAzBXRwxZA?=
 =?us-ascii?q?2wfFiAJPAsEDB8CGx4NKxYEDgMZKx1AAgELbT01CQsbRAInnURtgk4ZBz1RA?=
 =?us-ascii?q?SkBAQRJA18iCSMFKhySTy4MgwkBrnkHgjGBXowBjRuHcgYPBC+FV5FUkk8um?=
 =?us-ascii?q?A6NZZR5M4UXAgQCBAUCDgEBBoFkATqBWTM+T4JnCQk9AxkPjiA4g0CFFIpnQ?=
 =?us-ascii?q?TMCAQouAgcBCgEBAwmCOYQUhH0BAQ?=
IronPort-PHdr: A9a23:fnYG8BzzZjOzuF3XCzKQy1BlVkEcU8jcIFtMudIu3qhVe+G4/524Y
 RKMrf44llLNVJXW57Vehu7fo63sCgliqZrUvmoLbZpMUBEIk4MRmQkhC9SCEkr1MLjhaClpV
 N8XT1Jh8nqnNlIPXcjkbkDUonq84CRXHRP6NAFvIf/yFJKXhMOyhIXQs52GTR9PgWiRaK9/f
 i6rpwfcvdVEpIZ5Ma8+x17ojiljfOJKyGV0YG6Chxuuw+aV0dtd/j5LuvUnpf4FdJ6/UrQzT
 bVeAzljCG0z6MDxnDXoTQaE5Sh5MC0ckk9UH1Pu7jXTcrL0qTrQsOFshGrHApT0DpluZTO/3
 Z1LdUP4riZEOiQl6SLy358V7upR9SOsmTBw/pLUStuoOtZkQ/7bes8/WE9kctsSTRQePKeER
 NNeLuglHttqioTe4HlWkzGcOgydD9jNkRhOn12p/ZVi6P0LTyX92DI5L+8psGbGt/71b/0Wa
 8LtlLjjyBHOVeNJ+TSi+svZSE1wmfO0TZt7KfX04EsiOlnVil60jIX7P3TE5/g0ijmU4eh+C
 v2EgTEqtC9D+DrwxuF8kI3guN0T5E3D6TtQ4akIBIjrAF4+YMSjFoNXrT3fLYZtX8c+Fnlho
 z1polVnkZuyfSxPzYgu5DeFOrqJaYGV5BLkWuuLZzt11zppe7O60g676lPoivb9Wc+9zEtQo
 2Jbn8PNuHEA212b6sWORvZnuEb08TiV3h3V6uZKLFpykqzeKpU7xaU3mIZVukPGdhI=
IronPort-Data: A9a23:7Jw5GqyOXOdsiRgk05p6t+eVwirEfRIJ4+MujC+fZmUNrF6WrkUBy
 DZMWD2EbKzYY2akf4txPtm38UJU65SHyt83HAtopVhgHilAwSbn6Xt1DatQ0we6dJCroJdPt
 p1GAjX4BJloCCWa/H9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7dRbrVA357hWGthh
 fuo+5eEYQf/hmYuWo4pw/vrRC1H7KyaVAww4wRWicBj5Df2i3QTBZQDEqC9R1OQrl58R7PSq
 07rldlVz0uBl/sfIorNfoXTLiXmdoXv0T2m0RK6bUQCbi9q/UTe2o5jXBYVhNw+Zz+hx7idw
 /0V3XC8pJtA0qDkwIwgvxdk/y5WJqYf//jrGl2F4Y/QzhHiI2no/M0pNRRjVWEY0r4f7WBm7
 vkEMHYAfhuDweysya+9Su5ii95lIMSD0IE34yw7i2CGS695ENaaGfqiCdxwhF/cguhLHP3eb
 scdLyVibQ/bSxROIVocTpwklfquhn7xficepF/9Sa8fvTSOklwoieaF3Nz9ZPiWZeRen1+kn
 U2FpSPIE1ZKZdG7xm/Qmp6rrqqV9c/hY6oKHaC83uZjnVnWw2sUEhBQXly+ydGwjkOuUtRTJ
 lY8/ysupKwz/12tCNL6WnWQqmSNoxgRQfJTHvc85QXLzbDbiy6QHXQsTTNbbtEi8sgsSlQC2
 laPnt7tLT1ov7CcU3ia5vGSoC/aESETIXUDZAcHQBED7t2lp5s85jrKR8x/EajzitToMTXxx
 S2a6iQzmd07lskN2I248ErBjjbqoYLGJiYk5h7/UGjj5QR8DKanYIyur1bS9upJJoufQnGOu
 XEFn46V6+VmJZKVjy2LT+UlH7yz4fuBdjrGjjZHBJUv3zuq/HGncMZb5zQWDEdgNcIZfhfmZ
 0jcvQ4X75hWVFOoaqtsaqqyBt4swKymEs7qPtjNc9dIfpl3XA6c+z9nYUOWwybml01Eub8+I
 5CzY8uqDGhcDaVh0SrwQP0Sl6Iorgg7xGDXQovT1Aaqy7eSZTiVVN8tOV6PdL9i7aesrwDc8
 tIZPMyPoz1EXffxbwHX+IoXPFZMJn8+bbj8s8J/aOGOOExlFXsnBvuXxqkuE6RhnqJIhqLL8
 2u7V0tw1lXynzvEJB+MZ3Qlb6ngNb57rHQmLWkiJlqlxXUnSZig4b1ZdJYte7Qjsut5wpZcS
 /gDZtXFGflEVy7G5yVYaJ7xsYhvXAqkiBjIPCe/ZjU7OZl6SGT0FsTMJ1a0sXhRS3Po5I5n+
 eLmyAadStwNXQ1/CsbRZv+1iV+81ZQApN9Ps4LzCoA7UG3i6oF3LSz2gPItZcYKLBTI3DyB0
 AiKRxwfoIHwT0UdqbElXIjV/tv7IPg0BUdAAWjQ4JC/MCSQrCLpwpZNXKzMNXrRXX/9svfqL
 +hE7eDOANtelnZzsq14D+lKy4A67IDRvLN09FlvM0jKSFWJMYleBEe68/NBjYB3/Y8BizCKA
 hqO3vJ4JYS2PNjUFQ9NBQg9McWG+/ImuhjTyvUXIEzKwitG7eeCWkB8ZhOJiDJvKYVkFIYfx
 cYgp88kxAitgTU6Mtu9r3519kbdClciQqkYppUhL4uzsTUSy3ZGeo36Ni/6xLqteud8GBAmD
 RHMjZWTmokG4FTJdkQCMETk3M1ftMwogw9LxlpTHGa5sIPJqdFv1SIA7AltaBpeyyhG9OdBO
 mJLEUlRDofW9hdKgPlzZUydKztjNja4pHOok0AokVfHRXaGTmbOdW0xGdic9XAjrl5zQGJpw
 6G6+k3EDxDRY8DD7gkjUxVEqtvib+BL2C/spcSFJ/mBTr4GOWfLo6n2fmcZiQrVMeVojm39m
 ORa1uJRa6r6CC0un5MGG7SqjbQ+dD3UJUhpY+1Qw6cSLGSNJBCwwWevLm6ySONsJtvL012yO
 /ZxAsdxCyXk2zu8qBIbCZFRJLUurvoi5YcBSIjKPk8DiaOU9RBygaLT9w//pW4leMpvmsADM
 bHsdyqOP2iTpHlMkUrPkZV0AXW5atw6ewHM5uC53+EXHZYlsus3U0UN/parnneSai1Lwgm1u
 V7dWqro0OBS84RgsI/yGKFlBQ/vC9fSVvyNwT+joeZ1ctLDHsffhTw78mC9EVxtAoIQfNBrm
 ZCmkt39hhrFtYlrdVHpocCKEq0R6PiiWOZSDNnME0Bbuim/Q+7p3QoI/jGpCJ5Oke4F3PKde
 SmDVJKSe+IWCvBn/18ETwhFEh0YNbb7Ube4mwO5sMa3K0Y81S7pEYqZ0EHHPE9nch0GAZncM
 jPPmu2P44lYpbtcBRVfCPBBBYR5EWDZWqAnVoPQsBeABTOWgHeHiKrTpSQ94B6aD0u0MdvIz
 q/EYjPcdx2Cnr7C4/8Eko51vzwRVG1ch8tpdG0j2tdGsRKIJ09YEvY8aLIoUop1lA7237HGP
 AD9VnMoU3jBbG4VYCfC78TGdSbBIO43Y/PSBCEjpmGQYAeIXLKwOqNrrHpc0i0nawnY7b+VL
 P8F8SfNJTm3+JZiQNgT6tGdgetKwvD7xGoCyXvikv7dUgovPrEX6ENPRAZ9dzTLM8XopnX5I
 WIYQWNlQkbibWXTFc1mWWBeGTBHnTfJ4ggrUxyyw4fki93G9NFD9fzxBbiimPlLJsEHP6UHS
 n7LVnOAqTLekGAavawy/cklm+loAPaMBdK3N7LnWRZUpayr92A7JIkXqELjli35FNJ3SDsxT
 gWR3kU=
IronPort-HdrOrdr: A9a23:2KDZ7qvJ75byMTYx9FBwVoRU7skC7oMji2hC6mlwRA09TyXGra
 +TdaUguSMc1gx9ZJhBo7G90KnpewKlyXcH2/h2AV7EZniYhILIFvAf0WKG+VPd8kLFh4tgPM
 tbAtJD4ZjLfCVHZKXBkXmF+rQbsbu6GcmT7I+0pRcdLj2CKZsQlDuRYjzrY3GeLzM2YqbReq
 Dsn/av6wDQHUj+Oa+Adwc4tqX41pb2fNWMW29zOzcXrC21yR+44r/zFBaVmj8YTjN02L8ntU
 zIiRbw6KmPu+yyjka07R6f071m3P/ajvdTDs2FjcYYbh3qlwaTfYxkH5mPpio8ru2D4Esj1P
 PMvxAjFcJu7G65RBD+nTLdny3blBo+4X7rzlGVxVPlvMzCXTo/T/FMgIpIGyGpnXYIjZVZ6u
 ZmzmiZv51YAVfrhyLm/eXFUBlsiw6dvWciufR7tQ0QbaIuLJtq6aAP9kJcF5kNWAjg7po8Le
 VoBMbAoN5LbFKhaWzDtGUH+q3iYp0KJGbHfqE+gL3X79AP90oJjXfwhfZv0kvozahNCqWtvI
 //Q+FVfLIndL5gUUsyPpZEfSKNMB25ffv9ChPgHb3ZLtB0B5vske+/3Fxn3pDjRHVP9up0pK
 j8
X-Talos-CUID: 9a23:AsB6WGNAs6qqpu5DQyI+8wk4IeUfIj6ezSv0c128Nl4ucejA
X-Talos-MUID: 9a23:8ziwLAZhniuY6OBTqRvwpBBpNd5U2IvtUgc8gNJW6sSgOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,250,1694728800"; 
   d="scan'208";a="64568116"
Received: from 153-97-179-127.vm.c.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 20:11:42 +0200
Received: from XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) by
 XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Wed, 25 Oct 2023 20:11:42 +0200
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169)
 by XCH-HYBRID-04.ads.fraunhofer.de (10.225.9.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Wed, 25 Oct 2023 20:11:42 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHXH3365bgwKDkl1ZQlSmGWN0ci3S55teYJKEdp0fjBkUZvxMrQ8oAjav/cyJz5smjD54sCVsqTi2lCazV7XYOvwu4VBptJui/uGzPpjRyTnJN6Gg1V5Z46ZPPIGsr/3KOjM8kOg26j5K89nR7/l4iTLsNx/wt/0F2k/ochT5Cbqg+grMaNwFY64dxzPRy2WURdJ8Sw37+N4c8HTbIEy9+1MfqQtlv/Yh61bXjIDZmWmC7KXjwyT6ipPH3MkqLuj6JRIOAS4xBWVg53qKdiLKhtXC0g3q4scea0imXLJZuO/LUjQQFh1C04JM8FANYqMQirwWTgwlnmSigdh9TikNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt3CjLADMmsyBncy4+5W1j+A2TouZRHU4xNi+ertq+M=;
 b=i8uAp59/pxmr9FscoRLlskHCUs2NglNPaFd4phqSb209bNXH9iYKs5LdlbGQ+EYJhveSVsml0xSFePQFpUwxb4uLAD5D3LwuKSqQCAUd1hExJBfPShl/zo7rZl/74bzF8Yaugla+0P6Il88TpMasMQI+NBxmLerKLciILGqDJLSoIip1iFjThHs/nFoYAvx26mm9HqL0DlA64AC6cGZHbBehfRkIiL/3hj0paMoMHAueU97txoAA8ipeTc0/H941TJKCS/Y9VZzQAQMOfI3+rTnwvpe+lcIBSKs8XazHZr4LsiIC5ygYxnS9MBW1U3Mp0HY0bSxyYjdxr/AeporWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt3CjLADMmsyBncy4+5W1j+A2TouZRHU4xNi+ertq+M=;
 b=YeVDgUthB2UfDrU5notMuMMDu+rP7VLPC09IjLKUZMeK/J0VBJWmYcSJ3OnqJ7HP0SqB6LSlVqXUOhzzsCh32lRJ00yCmLeRxwHk7z+yR59PjPxAc0WMAjeE2xlcLMavh/9YtQQ9gfjv7wCb7ewFZ2j7hN8rlAV7nFuotvAIGUI=
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:50::14)
 by FR3P281MB1663.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 18:11:38 +0000
Received: from BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d]) by BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7330:78f8:1bf2:2f4d%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 18:11:38 +0000
Message-ID: <46e27d66-ff40-67c0-5c5f-29e28bf34b9f@aisec.fraunhofer.de>
Date: Wed, 25 Oct 2023 20:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND RFC PATCH v2 00/14] device_cgroup: guard mknod for
 non-initial user namespace
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
CC: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner
	<brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Quentin Monnet
	<quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos
 Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, "Serge E.
 Hallyn" <serge@hallyn.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<gyroidos@aisec.fraunhofer.de>, <linux-security-module@vger.kernel.org>
References: <20231025094224.72858-1-michael.weiss@aisec.fraunhofer.de>
 <CAHC9VhThNGA+qRgs=rOmEfvffj3qLzB=Jx4ii-uksuU1YJ6F5w@mail.gmail.com>
From: =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>
In-Reply-To: <CAHC9VhThNGA+qRgs=rOmEfvffj3qLzB=Jx4ii-uksuU1YJ6F5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::18) To BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:50::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BEZP281MB2791:EE_|FR3P281MB1663:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb02472-766d-48fb-3c16-08dbd585d4fd
X-LD-Processed: f930300c-c97d-4019-be03-add650a171c4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lS/rN0c/TxKctsQ6WpTStI0PsSRFZVS5royDXBmd0ztNAZVe24Mp4QTdQcDJpAefpMxRRcc+dvHSgiOpeAy7Qprbgl1Avy8mrSQP5kIYos/yaEP7FmFTt7cgHdMilqoXd1wOtDDef3Y1XAEv+SuFw9cwsmi4z/dBvBxzZbAPi1urajNTtztmI8570W8EZ3WQkbYE3YtvNR3eVza/c0+qwfnBHCPX6TLvTkjRrtdPAyWinrDNQjTle7dX8iicbbw6fXcY+du4C2Mx85wgk5/MBMXt/j26ae/910xPlXFYXynnkZubJrx/ZUmVUZHhp99CvdGJgVlixyGtPlJB1wz7+H0yV5Auw8FD27Xl+5esXQ4pl/5HrOCbJm27mXsfOux9jlWGaEk6orEH6Ex7GfxSOx8x5arYINGzzIX0cQ3CLjdBLHIFl3cJIXGbhta3se2/hTPt7xxNJSG9timssJYdNhHP7YAJvB17SU4AGwddxRQ5KScHcC8Rjq8rMvW1VX70mrRyiI6lvJwRvQeF3DscQHB13O0oI5LzphE5TTW4ZuWA//Dh2DY7h8vZ3JwawGBaJutLaQLofPLWpKSCByibMoMeHmzskewnb5NpyaJka8N1jHE57cqL7CQjD/J86ahR1uriNQ87aBJLEDmrWT+bC1WuM6FNrkIq9ZvQHLJ1rIzbOwyPhgbMvddHwkXAol0f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(1800799009)(186009)(451199024)(83380400001)(31686004)(7416002)(8936002)(2616005)(2906002)(4326008)(82960400001)(53546011)(8676002)(38100700002)(6512007)(6916009)(5660300002)(31696002)(6486002)(316002)(508600001)(6506007)(966005)(66946007)(54906003)(66476007)(66556008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhlZDhZL2RVZS9WMmpSUytjSE8xVDRoR0VERGJoNWhBZ3ZraXZNUEwvS3Zh?=
 =?utf-8?B?QXFKWFFNNXJWUVByOHNXK1F5SHFhMDUyQmFiTkVuT3l6OVBMazVuNGVhNWpo?=
 =?utf-8?B?bDllbkNyUVJIcC9BVE9KSk5qell3c3dlZTc4bXdlNkpVdFR5YkhSR1JWNVhK?=
 =?utf-8?B?S0JiZTlPeURDNlI0RDhxdE81K0xwN2tjcTY5SnFaK2xKZnd1NGl0YXpWTnpW?=
 =?utf-8?B?R00rYTBUL3pLU0dsZW81VmRVRTZxbk9nbVY2c3FlWWFWK0duRkk4WnErUXRG?=
 =?utf-8?B?TXh0WnN2UWYvbE8yQnJzZmY5b1hKQmljNnlrdkgrbXZXWlVLaDcxUzFCZTl3?=
 =?utf-8?B?cGcxbDhZeW5uQnNkL2l0OUgweVdWVkNNK3JNL3R1aGtNdEdFM2xsNC95SDl3?=
 =?utf-8?B?OGpKazMyeUVGWEtqOURPazdVaXBidkViTG1mRjlIZXptOEwyb1hySWZlcGIx?=
 =?utf-8?B?QTB0cmN5OWd4MUVtSk5UMkFwNDExZjlqbVZ4cEJESDlndmpFTU5YNWp5SGJX?=
 =?utf-8?B?QkUyZW4xSUI1SkxKRVJBVzZRcHlKT1RHcEJucXRoL1dFQncvZzVuS2FGQ0cz?=
 =?utf-8?B?UDFLb2pta0ZmdGdJTWlLM1U5dDlNVHNEWVdoTUpLekd2M0w4bEFmeCtIcGth?=
 =?utf-8?B?ZTJVUWxGclpTb0tyenU0MUgvMG44MncwRXVYSEhIa1BCbGsvSTNuQkpnYzl5?=
 =?utf-8?B?VFJpNXlhbzBYSHB1bmkrME1qcDFrTDNzMWRWb21sNWJGQ3lVTFNTV3VNQ2gw?=
 =?utf-8?B?emlsemlqQWhkL2ppR0R0VS9LVHU0Q1VuYThyblE5QjVEUjZzbWd2cDNNQ2dT?=
 =?utf-8?B?ckZDcTFFVUtCbXNOdFJUamlTSmlPMFRORVBNWDlJWXUzdkQrMGNXUDB0Q2U4?=
 =?utf-8?B?bGV3Zml4S2Z1V05iaVg2MitZOVFWVFdKcjVaS2xXbFFjRGllTU4vN3dZQ1Nk?=
 =?utf-8?B?OHFsck1nRURvci9CdDBaUlluTWJjS1dqWk5VYnpDTTJZK1gyUWhFM25ka3Yv?=
 =?utf-8?B?TklUUCtPV21GbVd1NTZHNDJqNWp3bWRRbnNzYU9CdUtDMFgzcVVrQWEzb2p5?=
 =?utf-8?B?eVJtdHQ4R2d4YkNDb0hsSS8wYVVFK0lNR2Z5RWdJb2F0MkM1Slp0RThVeVJK?=
 =?utf-8?B?NFkvQ2NlbXpCRDYyMW5KcW9OVGE4Y0ZjM2xzb3hSNjVER2thUXp5b1lFRllM?=
 =?utf-8?B?Tm5xZkxpbXhDNTI0bzJqZDgzaCtxWnhSdTdnclhKLzZzaUlYQnJCL25sM216?=
 =?utf-8?B?QXFsVjlROFFIYWdudS9uYUdhbzlrSDllZzJHVmozWU5oVkUyTCtlKzBwVWpO?=
 =?utf-8?B?M3pLRTBLRDB3b053b0lRbGgxUFlobG4xblAxbU1kOVRnNGY3dE5sVkVWQ2Jl?=
 =?utf-8?B?UmJXSzJ0Q2wzb3crWkFHOHhmMHQ1QXNzdzM5Wks2REVWbVBkTUVoazV1bC9C?=
 =?utf-8?B?RW9QY0UvZDVpSlFsVGFhT29IVytyWXp5Q2NXTW83b2ZuQks3bC9QTXJDYVkv?=
 =?utf-8?B?bFNIYlo4QXVtQVU1dXJHVkN5eWRwWHpva0w0MHRwWnk2N2xWMkFPcUxKWFFI?=
 =?utf-8?B?M2FtRnZKM1k1c0Z1dFJUUFlkclV2V201cHpoc2syeUF2Y2hnbEZCd21nUzdG?=
 =?utf-8?B?U3YwMkpENXdJSElXcDZSejZvTXNWWU1UbUpzeGlMdng0MGROdUJWb3U3S2Vx?=
 =?utf-8?B?cGJrWCs1SU9XaGh2VDBlK0JBc3VJRzY3MDY1S082VlNxYS9NQmM5NHN6OXFM?=
 =?utf-8?B?L0J0djY4eEkyK1dIWWczSVhTeksvVER5eVNZQXJlN3hpdXdhVWFVTGhzNE5a?=
 =?utf-8?B?NTZGSHcwMlJkbk4rcUlwSWVhZytzbXRORFBtbjh1QWxDejRGWmlYOThnMlA5?=
 =?utf-8?B?VFZyNGg0K05JK1ZQdFJURTRTNTJZMTdabmszQnRpODhaNWdvK2NtNldwb3pw?=
 =?utf-8?B?WjFCL1QyYldjUjcycjhubEw3RnBJVGx4T1lVMWJxV0tJTXZoM2hCK0JpZUpE?=
 =?utf-8?B?UVJPRTBGU0wxYk93TFpFVUxlMVFQL05KWkd5MTRkTnNTUEpYRmc4SUREYlUz?=
 =?utf-8?B?M2hDcHBwNVpiY2FlTFpMTTVPSkdMVm1QWm4weWFRYlJUV3VGdUVSZFIwbFdj?=
 =?utf-8?B?Umx3NDlBNG1qWEoxV0MzRGk5cWRETGlTVDhOWjRSamVmejl1cVFxZzZSQWRF?=
 =?utf-8?B?b2oyWFN1eXJhOHlNZ2NYbUp6VHE1ZjBSWS9tbnA0TldxdGJxWXBLZFQ2YUFT?=
 =?utf-8?Q?KAeMGVwHUx0YG6LS9mZwWf0JLpvNscjEibWxTimPAY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb02472-766d-48fb-3c16-08dbd585d4fd
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2791.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:11:38.5205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQGbBc1tebpcHP8SG8j3luZSYAk2/LoEycw8CyP1sj6slwBzYiNtC9RFmkMVNzPioP9d1BG9k3ouRiVfigIuBXqfBehGMoz57r4f3LwCAewItWiplAHBTJX3f+XIeugy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1663
X-OriginatorOrg: aisec.fraunhofer.de

On 25.10.23 15:17, Paul Moore wrote:
> On Wed, Oct 25, 2023 at 5:42 AM Michael Weiß
> <michael.weiss@aisec.fraunhofer.de> wrote:
>>
>> Introduce the flag BPF_DEVCG_ACC_MKNOD_UNS for bpf programs of type
>> BPF_PROG_TYPE_CGROUP_DEVICE which allows to guard access to mknod
>> in non-initial user namespaces.
>>
>> If a container manager restricts its unprivileged (user namespaced)
>> children by a device cgroup, it is not necessary to deny mknod()
>> anymore. Thus, user space applications may map devices on different
>> locations in the file system by using mknod() inside the container.
>>
>> A use case for this, we also use in GyroidOS, is to run virsh for
>> VMs inside an unprivileged container. virsh creates device nodes,
>> e.g., "/var/run/libvirt/qemu/11-fgfg.dev/null" which currently fails
>> in a non-initial userns, even if a cgroup device white list with the
>> corresponding major, minor of /dev/null exists. Thus, in this case
>> the usual bind mounts or pre populated device nodes under /dev are
>> not sufficient.
>>
>> To circumvent this limitation, allow mknod() by checking CAP_MKNOD
>> in the userns by implementing the security_inode_mknod_nscap(). The
>> hook implementation checks if the corresponding permission flag
>> BPF_DEVCG_ACC_MKNOD_UNS is set for the device in the bpf program.
>> To avoid to create unusable inodes in user space the hook also
>> checks SB_I_NODEV on the corresponding super block.
>>
>> Further, the security_sb_alloc_userns() hook is implemented using
>> cgroup_bpf_current_enabled() to allow usage of device nodes on super
>> blocks mounted by a guarded task.
>>
>> Patch 1 to 3 rework the current devcgroup_inode hooks as an LSM
>>
>> Patch 4 to 8 rework explicit calls to devcgroup_check_permission
>> also as LSM hooks and finalize the conversion of the device_cgroup
>> subsystem to a LSM.
>>
>> Patch 9 and 10 introduce new generic security hooks to be used
>> for the actual mknod device guard implementation.
>>
>> Patch 11 wires up the security hooks in the vfs
>>
>> Patch 12 and 13 provide helper functions in the bpf cgroup
>> subsystem.
>>
>> Patch 14 finally implement the LSM hooks to grand access
>>
>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
>> ---
>> Changes in v2:
>> - Integrate this as LSM (Christian, Paul)
>> - Switched to a device cgroup specific flag instead of a generic
>>   bpf program flag (Christian)
>> - do not ignore SB_I_NODEV in fs/namei.c but use LSM hook in
>>   sb_alloc_super in fs/super.c
>> - Link to v1: https://lore.kernel.org/r/20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de
>>
>> Michael Weiß (14):
>>   device_cgroup: Implement devcgroup hooks as lsm security hooks
>>   vfs: Remove explicit devcgroup_inode calls
>>   device_cgroup: Remove explicit devcgroup_inode hooks
>>   lsm: Add security_dev_permission() hook
>>   device_cgroup: Implement dev_permission() hook
>>   block: Switch from devcgroup_check_permission to security hook
>>   drm/amdkfd: Switch from devcgroup_check_permission to security hook
>>   device_cgroup: Hide devcgroup functionality completely in lsm
>>   lsm: Add security_inode_mknod_nscap() hook
>>   lsm: Add security_sb_alloc_userns() hook
>>   vfs: Wire up security hooks for lsm-based device guard in userns
>>   bpf: Add flag BPF_DEVCG_ACC_MKNOD_UNS for device access
>>   bpf: cgroup: Introduce helper cgroup_bpf_current_enabled()
>>   device_cgroup: Allow mknod in non-initial userns if guarded
>>
>>  block/bdev.c                                 |   9 +-
>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |   7 +-
>>  fs/namei.c                                   |  24 ++--
>>  fs/super.c                                   |   6 +-
>>  include/linux/bpf-cgroup.h                   |   2 +
>>  include/linux/device_cgroup.h                |  67 -----------
>>  include/linux/lsm_hook_defs.h                |   4 +
>>  include/linux/security.h                     |  18 +++
>>  include/uapi/linux/bpf.h                     |   1 +
>>  init/Kconfig                                 |   4 +
>>  kernel/bpf/cgroup.c                          |  14 +++
>>  security/Kconfig                             |   1 +
>>  security/Makefile                            |   2 +-
>>  security/device_cgroup/Kconfig               |   7 ++
>>  security/device_cgroup/Makefile              |   4 +
>>  security/{ => device_cgroup}/device_cgroup.c |   3 +-
>>  security/device_cgroup/device_cgroup.h       |  20 ++++
>>  security/device_cgroup/lsm.c                 | 114 +++++++++++++++++++
>>  security/security.c                          |  75 ++++++++++++
>>  19 files changed, 294 insertions(+), 88 deletions(-)
>>  delete mode 100644 include/linux/device_cgroup.h
>>  create mode 100644 security/device_cgroup/Kconfig
>>  create mode 100644 security/device_cgroup/Makefile
>>  rename security/{ => device_cgroup}/device_cgroup.c (99%)
>>  create mode 100644 security/device_cgroup/device_cgroup.h
>>  create mode 100644 security/device_cgroup/lsm.c
> 
> Hi Michael,
> 
> I think this was lost because it wasn't CC'd to the LSM list (see
> below).  I've CC'd the list on my reply, but future patch submissions
> that involve the LSM must be posted to the LSM list if you would like
> them to be considered.
> 
> http://vger.kernel.org/vger-lists.html#linux-security-module
> 
Hi Paul,

thanks, I'll keep this in mind for the next submissions.

I have also resend because, I realized that some spam filters my
have swallowed the last submission as I used my private smtp server
from another domain in the gitconfig. Sorry for that. I hope now
every one received it.

Thanks,
Michael


