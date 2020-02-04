Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021E9151D1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 16:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgBDPWf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 4 Feb 2020 10:22:35 -0500
Received: from smtp.eckelmann.de ([217.19.183.80]:55128 "EHLO
        smtp.eckelmann.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgBDPWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:22:35 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Feb 2020 10:22:34 EST
Received: from EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e035:172:18:35:4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1591.10; Tue, 4 Feb 2020 16:07:31 +0100
Received: from EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6]) by
 EX-SRV1.eckelmann.group ([fe80::250:56ff:fe8b:faa6%3]) with mapi id
 15.01.1591.017; Tue, 4 Feb 2020 16:07:31 +0100
From:   "Mainz, Roland" <R.Mainz@eckelmann.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>, Jan Kara <jack@suse.cz>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Jan Kara <jack@suse.com>,
        "Mainz, Roland" <R.Mainz@eckelmann.de>
Subject: Implementing quota support on Linux without block device as backing
 store ? / was: RE: [PATCH 1/8] quota: Allow to pass mount path to quotactl
Thread-Topic: Implementing quota support on Linux without block device as
 backing store ? / was: RE: [PATCH 1/8] quota: Allow to pass mount path to
 quotactl
Thread-Index: AdXbbKDrCgOz0kbdRUqDYOUqf+uszQ==
Date:   Tue, 4 Feb 2020 15:07:31 +0000
Message-ID: <db98497119d542b88e0cfc76d9b0921b@eckelmann.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a00:1f08:4007:3c00:f91e:e10f:9d83:89d4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org





Sascha Hauer wrote:
> This patch introduces the Q_PATH flag to the quotactl cmd argument.
> When given, the path given in the special argument to quotactl will be the
> mount path where the filesystem is mounted, instead of a path to the block
> device.
> This is necessary for filesystems which do not have a block device as backing
> store. Particularly this is done for upcoming UBIFS support.

Just curious: Did you check how NFSv4 (also a filesystem without block device as backing store...)  implemented quota support ? Maybe there is already a solution...

----

Bye,
Roland
-- 
Roland Mainz, MAA/CAS
Eckelmann AG, Berliner Str. 161, 65205 Wiesbaden
Telefon +49/611/7103-661, Fax +49/611/7103-133
r.mainz@eckelmann.de

Eckelmann Group - Source of inspiration

