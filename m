Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA81EE6DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgFDOoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 10:44:07 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:34274
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729034AbgFDOoH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591281845; bh=7Kz5EI0QHJAxjyLQblW/9S/KIIFX+xRHh9BN8P/3dys=; h=Date:From:Reply-To:Subject:References:From:Subject; b=FBfbYQTkxCi91gVGQZ4MXGnH/VDcm9XuZTeEvhHYOiXNzNYyvTVKqD0LpHJoIUXvlFnPm7nzsV8OKe/6okUko2SGQub9n2BvLAB41aQmHdY/9CfCr07PHmsPV2Dd82Xs44qQvNZmAS0BQaAZGQI1IYfcmrMfZ5nlnq2HwgVag2RaOMDBj2P9GbcWWyPi+gKB95cGyWzKTuIDG8nzkp77QX1GwIaLqgzIPGdLEwsVDxttsH/JLEtWwoIBvPPxYpLLYdDmC3tS0JaCFd/IznIl2F+ndHtHVUHoIKr7xf6iVrEBr8499VHZcPgWorm3vANL8YwZTut384IUVMmNPZhr9g==
X-YMail-OSG: m0O3e8AVM1mlCVnE3yT8rlJUQnWVlf2OB2ScHyKYQZqERGwsIovTfsaD6ZxVCpT
 gcN2C8tsfK44yoVC8qC7ppZJvg41bzCVymTfCm2_WOsC0T3datYQ1yQU3E5tOeuFwnBAVP78zKR3
 mEAWegA9AyCyHNxJKTJEq_YfK9LqUl9VSg8MQxuoU_FM0VYmmPYtThB4C2XHGQ23nyJ7p2wKlZrl
 eIhndMM5exGZCdbXaSI8JNnXV.hSrHtJmseo1NAeTm4fCuHSwim4cxe94i99u6eaDeQLHzbbcfER
 E6kw1zcvEHV7b5ZgGTGe0ODTmlu9Viiype.PXH1TlOEaUWGPmXtidrZYMMf.mD9v31.HFJtNxbVe
 6hr6uHzIS1XsVEt0Zvt_kob_EtsJ_TI_E5hSQG0yz99.DOZPhyy7m02rC.pEMu6DeFB..tJbVaJY
 .1LNMsZomat8djFqxCGdp1A8Cy_LX8sL455TtYXAnhwgiqyEz4_gVaapPhm7Zk5ttTOz9g3bHv9p
 OVFR3cco6q1B_f0erD2bgUUZeGnrBYtw3xK8_2XDyxN76rFMEDLLyNlolqSHW1Ge0BcmvnTdI_Vr
 I8Z8PKiB2jrimM4iHoc14Mvl9yzJ8UGyh7Kdx1iGEPTCppTV9GkJzZeZ_38hfr1riweVpnzkUct9
 bnC5WYd5EM1teEgnZsaWUp5JDJQQGnUTjJARIRCGTMbj0s6RofNhTaQnwKJqYzndFf1I4MlWD6rQ
 oKf8YMWVi4n3c0bUPQkcqB8LkmX_UMM3AuXlMFc8f7dv__JPeJGyqs8xCgfuDs5mWgQOU1Dc0U6J
 kJmHaz6gvw5IWWNINdp3l_ChIr2ouY3Hu3xjIeR4k7m_huxiiq9LJonH4fofDI6qlcHq.zwqTeCA
 piVRnqAwhmS.MafbrsvNHXo3CU4fxQu7VmIFulxq83Xz2ZzVw9D8vPGe4bivO9RIHmldEcMQf5D6
 aBodeMThY_t1P_v1EpI6isDWDmePtZMtpZer87U67mhws_V.DSjAlLX0cXK6R3NN.nNR07EBHJrR
 l9vpd3WRnhdhsg_UYPQT_LpAjpAh4jAcEDlGz75mJHhKx8c4wVhOo8HhsZh.Myy4GWi_72.HoMgl
 cllSI1ySUkSS.yeTx_jaZ0WAgvOlsdQ_yjhZE1rP553stb4iliof4cj_7UM2D2Bizq2tPMqtzMf3
 odbqAh9.X20JRD8sCpwBnSdHtweRXm96sbFNQXhA2zAS9AURMfIZQ8ND5T3sCIBz.TwQSniLTdNW
 nHzf9IKLcKBl3V9G28v5jQMK14sAP8tpXu3OIJM7jzCWkhvSYpFay0Rsm7Kn3qCfBZRQcpum9Dwk
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Thu, 4 Jun 2020 14:44:05 +0000
Date:   Thu, 4 Jun 2020 14:44:02 +0000 (UTC)
From:   Henrita Pieres <henritapieres@gmail.com>
Reply-To: mrshenritapieres1@gmail.com
Message-ID: <826170059.1851218.1591281842972@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <826170059.1851218.1591281842972.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dear,

Please forgive me for stressing you with my predicaments as I know that thi=
s letter may come to you as big surprise.  Actually, I came across your E-m=
ail from my personal search afterward I decided to email you directly belie=
ving that you will be honest to fulfill my final wish before i die. Meanwhi=
le, I am Mrs. Henrita Pieres, 62 years old, from France, and I am  sufferin=
g from a long time cancer and from all indication my condition is really de=
teriorating as my doctors have confirmed and courageously Advised me that I=
 may not live beyond two months from now for the reason that my tumor has r=
eached a  critical stage which has defiled all forms of medical treatment, =
As a matter of fact, registered nurse by profession while my  husband was d=
ealing on Gold Dust and Gold Dory Bars till his sudden death the year 2018 =
then I took over his business till date. In fact, at this moment I have a d=
eposit sum of four million five hundred thousand US dollars   [$4,500,000.0=
0] with one of the leading bank but unfortunately I cannot visit the bank s=
ince I=E2=80=99m critically sick and powerless to do anything myself but my=
 bank account officer advised me to assign any of my trustworthy relative, =
friends or partner with authorization letter to stand as the recipient of m=
y money but sorrowfully I don=E2=80=99t have any reliable relative and no c=
hild.

Therefore, I want you to receive the money and take 50% to take care of you=
rself and family while 50% should be use basically  on humanitarian purpose=
s mostly to orphanages home, Motherless babies home, less privileged and di=
sable citizens and widows around the world. And as soon as I receive your r=
espond I shall send you the full details with my pictures, banking records =
and with full contacts of my banking institution to communicate them on the=
 matter.

Hope to hear from you soon.
Yours Faithfully,
Mrs. Henrita Pieres

