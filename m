Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1681A1C91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDHH0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 03:26:15 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:14125 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgDHH0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:26:14 -0400
IronPort-SDR: jdC93wlaZSE56uMLyD6MvmmT68UGr2fv/uBsuWU1KCvH5F5MBjMNSeowcvy9MT08YBm+Gnu6E2
 ba2jiRwww9mQkRy/hx0Es6NQgwyaNNinwqp1JWkJi8FkwzAwAMdAUwelmPD+4d8L+QEsk7nXJU
 KIuftHhMx1D51KRDcVSg5SQj9Ui6DPEcPflbtLse6dsY03EDCFdm+jV913NSiuwsystZSpRHKf
 11npI76BbTq15WfmRWDFrn/63lfF6RtpOBz29gPDyZkOgrT7BH5Ey0dZkepoR5SYrqNvxREmia
 cgI=
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="47599622"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 07 Apr 2020 23:26:14 -0800
IronPort-SDR: /3VRTvqjzae+nNNrwtv/DAAyeGsd1/+/Nz9OLejgdmWpJd+lFUrwkFLAsankHd8mYbJIzUzEHQ
 x1LUI6F+VTSrBuncrlCiQaDxmWRq45Gx9yOkzxPT1QporYj1YvJ2nZCTJb2duocIUrirB0sIF1
 711paZ3l06aq5Ebh7bsIhqJp7zNR46c5i6dpsdwU8EfyLPTE5hqhYcWnU31JY/j5/Z6mJr4jUZ
 0EnW8yobSBuCLuXveRwwVJUSaXaCGtHloN2XiNHGg0jQPyYmw/RVxPKeLNEzKastZ2ka37wpiy
 iNA=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "motai.hirotaka@aj.mitsubishielectric.co.jp" 
        <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] exfat: replace 'time_ms' with 'time_10ms'
Thread-Topic: [PATCH] exfat: replace 'time_ms' with 'time_10ms'
Thread-Index: AQHWDXaV+mOELO8XJ0u2W2kinDcPLahu0rjg
Date:   Wed, 8 Apr 2020 07:26:08 +0000
Message-ID: <483f4d38d25a400499d3601ae18e041b@SVR-IES-MBX-03.mgc.mentorg.com>
References: <20200408072242.95334-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
In-Reply-To: <20200408072242.95334-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pg0KPiBUaGUgdW5pdCBvZiBjcmVhdGVfdGltZV9tcy9tb2RpZnlfdGltZV9tcyBpbiBGaWxlIERp
cmVjdG9yeSBFbnRyeSBhcmUNCj4gbm90ICdtaWxsaS1zZWNvbmQnLCBidXQgJ2Nlbmktc2Vjb25k
Jy4NCj4NCnMvY2VuaS1zZWNvbmQvY2VudGktc2Vjb25kLw0KDQpCUg0KQ2Fyc3Rlbg0KLS0tLS0t
LS0tLS0tLS0tLS0NCk1lbnRvciBHcmFwaGljcyAoRGV1dHNjaGxhbmQpIEdtYkgsIEFybnVsZnN0
cmHDn2UgMjAxLCA4MDYzNCBNw7xuY2hlbiAvIEdlcm1hbnkNClJlZ2lzdGVyZ2VyaWNodCBNw7xu
Y2hlbiBIUkIgMTA2OTU1LCBHZXNjaMOkZnRzZsO8aHJlcjogVGhvbWFzIEhldXJ1bmcsIEFsZXhh
bmRlciBXYWx0ZXINCg==
