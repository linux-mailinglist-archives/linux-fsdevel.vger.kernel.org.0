Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F247588780
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 08:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiHCGlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 02:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiHCGlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:41:17 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7923337A
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 23:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659508874; x=1691044874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1N9fWSiG3EQNjI1rJLu158VNR1+QkVu7iBvGe7TlrQk=;
  b=L+qlP4NpMQ6UjYiBiQpwdGXsPGxP9KC7VqO+SyCQ/x7CC48g8VFrkAUa
   y7/skoNQbKqcJhKYLvNMid4ShluuDQML1S1HBEkICKQn+1z5LydxOHf7U
   qdYTRzXeyfvkjw/nz9fXAw97MYjuzjGrDU8GqrVQfM4KlPSV1lWjF4Wsz
   2RlbQitCrXb3ukRsdv2ppgAKxtC/jNzTn2N20UHNagzcGQDqVzpP8h47r
   5TALedjmIDdBb0ic2Vm6qIW1DYr+9TU0berT2iM0cVDqcaD/4WeM2SnsC
   fv/jSY/x7udrlyDzrPAL1GlN/GbE/y/bI+AZ0GU8AeRp986Xf1VwHbT8W
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,213,1654531200"; 
   d="scan'208";a="212659547"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2022 14:41:14 +0800
IronPort-SDR: 3kC6KWW4j7AktQa2TqZjKFvF1r/GOB8HaENEVmwoQFv/RHN74PgVzONtMXjTgasTNcS/3lgBkN
 YYwsok9MI3AJmjQ3NZRcCP75SO+o7qy04exMMAfVa8paVoI72t9CAutlIpLD9ig+wfYZ8IC8Dx
 y5xYkJQHr2x9DCFOzkrjspu8MQT2EW87CflF/Iq4/tcEtHtVrraj5JfXNWl37yM+mbS22oScnS
 DFfSUd5E5GrZDXonqVZXhX0Tt9l8RUcWh64esHxk/PTXX+jlaezrJUxUYGUjOhl7GlSHGQ1afb
 gWLjOWZM7Q96JdM5VqRD8YyY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2022 23:02:19 -0700
IronPort-SDR: RDr4un4s5lBqfRDfOxxHNpkBd5DI5ZPJEw88uC78vx9FTDBM/RMa6eN907Kr2Sp+oYb+ZGsa+R
 48EmsVAnaGBa005Eas5rUuDtGT675TThko5Rb5HxGIoOzvuxA7y+/DMIhSDxUDLyT84hKguEbU
 B8qPlaokwMlO1985Eg4TN/QPg77e/fmwdGZT9lKWrkahIkNzBVL4DUIU5XOKxUIdht/P/FFkoi
 nKgHZGkSXFVUMXh1jyZsRxqCIdHi6WMKi2vzbt0Mx5ftW4TWUAgBcQGJAxECsehCEix5xYPGXg
 upk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2022 23:41:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LyMhC3Ldgz1Rw4L
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Aug 2022 23:41:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1659508875;
         x=1662100876; bh=1N9fWSiG3EQNjI1rJLu158VNR1+QkVu7iBvGe7TlrQk=; b=
        NazNIi3GcL5527gXs6ez2EmXxejneibXKbb8AbNL8MVCfslt0JE4lXodJA9Xnx/9
        JNpKr3bbisDKkaVrNRoqoS6nb7JNCwGArQMPPNbc+F+R0UDe67bHbmI6Gv/Efylq
        h+ROijsp6DQ9yQ5dAAZ0LUuy9CR7ggF1CzasvoQ0EjMaYM423iKTFcZ5ynN+umoS
        nF+LBmkNC1AU1768cwp75C4WZQzr2X5aw52IkP2RUzn4sOGfFUb5yu2Vhfru+p/y
        DnQvOYIAaOcuBAkYeIOO8fXDD4jHIAqv+qhxxRbGDNeoyQbIfNAPXWnVs0bXHV7i
        3AkQNfZmkkdHLLyUdQV1Uw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yZsCOKWaVs2v for <linux-fsdevel@vger.kernel.org>;
        Tue,  2 Aug 2022 23:41:15 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LyMhB4RBNz1RtVk;
        Tue,  2 Aug 2022 23:41:14 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] zonefs changes for 5.20-rc1
Date:   Wed,  3 Aug 2022 15:41:13 +0900
Message-Id: <20220803064113.986932-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus,

The following changes since commit 88084a3df1672e131ddc1b4e39eeacfd39864a=
cf:

  Linux 5.19-rc5 (2022-07-03 15:39:28 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs t=
ags/zonefs-5.20-rc1

for you to fetch changes up to 6bac30bb8ff8195cbcfc177b3b6b0732929170c1:

  zonefs: Call page_address() on page acquired with GFP_KERNEL flag (2022=
-07-07 07:30:36 +0900)

----------------------------------------------------------------
zonefs changes for 5.20-rc1

A single change for this cycle to simplify handling of the memory page
used as super block buffer during mount (from Fabio).

----------------------------------------------------------------
Fabio M. De Francesco (1):
      zonefs: Call page_address() on page acquired with GFP_KERNEL flag

 fs/zonefs/super.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)
