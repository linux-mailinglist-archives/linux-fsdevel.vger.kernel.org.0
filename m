Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F91525EE10
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Sep 2020 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIFOOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 10:14:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:48571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgIFONC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 10:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599401561;
        bh=/6GY+vCiDq3r2TFREQwT9xodDtp5h9Zbvasvf+ukhDc=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To;
        b=f8b1TbHB5nBpr/5rU77ygfCdcNwFmEBuZer9fbXiKjTPlhYDMHFD3w/3kXLevGJ+T
         eQ7+y7JbNbEts+CBA8v94FWPNkXG1oJOwQmhInPmYr23zulWJreKWYntQugtTvqUM4
         Mk1CaS41VrIBHmtFj9HiYoN5jm6uEfg3NQaMQKjg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([79.150.73.70]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42nS-1kEvPN0d5k-00079v for
 <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2020 16:12:41 +0200
Date:   Sun, 6 Sep 2020 16:12:39 +0200
From:   John Wood <john.wood@gmx.com>
To:     linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] Fork brute force attack mitigation (fbfam)
Message-ID: <20200906141239.GS4823@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906121544.4204-1-john.wood@gmx.com>
X-Provags-ID: V03:K1:P3aiXV9mY6GMjjapAhRGhTmCOrzLJZY8pCVrDvUl7xa+6uzqDKO
 vJdRkzRaaVJfqvTrMfjgo0rVclz+Om/Pl6Q0I6VBCH1UkeM6r9JASYlo8ZGFWYVfNg5tdnU
 0oiRFLVe30mB2g7GApgR8A9c2cVkjJ0R8MOzHxTMDNmoMiXaOi6UwVwP7KobNX8YVfd+olp
 RNhikYVv+UiR4cXt7UyXw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zvf/DhEzOAo=:YjCwUZOVpwc67MWJ3hJwsE
 ydZsW2uPEob5RH5Ts9TIwlMc1veiX95SnGmpWIrHCReX+RPaiY7u35dbFkzNmTLbniQ4sRCu/
 VcXgd2F2dLF14B7XPQcA+0FIyRas8lTf20yrVHT5XoJfDQuczW8G6ttePJldigKchOqv0Hzyg
 LcGLovcXRMz9CxZObqXLT7lRa9W0b/3hakNiyRMVgOjj0cLjzfZI6QC0l9ZeUtKoKTbVokbtp
 sWskaaqGTa43Ur/OEBrx/ic15HGCXEgGPl/ri8elmCaSIoPQgkZON0vJYEsBQlKlGXprLy2GT
 QiEJ6Y4PDmq+Sb99gPVEeawur1KsPOK3ilX2ycqTlgr7U9WrszsoPxP7gPDSvITOvfyLkILO6
 GNK8wvUHiRZdUq43VEPZbeFtK9kyx41IX6iHeT6jwPbkbc69O5mTqyawoqbINZrDR9fRqcs58
 pCYOkD7aSUZQA1qavw4+GrAKYsm5V0aR6WCRmELRHiEKqcs+AElq0cXjFT+llPtOJF/9FCUWJ
 1In0kpxkpn1wqg6X78mRBWgyG8/q1PazvH8cN8/VwnT3bQu6iJATPoncMbpB/hkqEbeHv0B2E
 WjYpzUrxGhQcWXmX1rvmx4mugNP6amkW+J/50vY5zzWqi9CnvtCop6d/3LCzbAPxCvrEMMIse
 nnE0r5O8c6vC5oafHjbeaZ/5BeSAAYxKh9FMEwt+MGg2saGQLs0hvlM3S3z2GLQE8vqn126m5
 BZR4flGD0t6Zl4N5vbHfmdBEkYS2mLmOch7u/w4W6WSA5ZjaN2ms3yZpbwLorvm2Vtw7tCBt0
 cAw8i2GO2pk8rqDBIYoVAr0l6ZbAyr7S5MGVbYmBHqp57hx1SGBlDaxYNTu1MTYCbLVE3DSsx
 /55QULhyCE5ckOhdz59x8ceFpsJYRoveH2lyXanIvlGN4ZvtzFPefEIanvaAiLSjNJTzCgChd
 prVX47egAwI/sLouU4q8R/gEwAqVhlRrGTbS6aoqlHYsOa3nXu8fmBAUWUf0kafKxanX1HhlV
 7iYkNQE7APm0smEDyc/zQ904LnbgZhDH0j+LtBbuqc3JJIlLlk1lA7tEkFTlPNamfE6RJuk+P
 kwy8LCVtp/uqUQQU4YliUKFSfEOEwJHWwxm2cg9IyG/O38Q4Ov1miBMBSZVmu/ivAI8AuSrA6
 8aUy5nMpS0J4P5bwDcO9nflI6h6gl0cq1qqTZzRpoOItNB3GSuT3+kpWEwTFtFZ5jDTrATaPq
 5RLczj2d5zRRT5I9dsxOF4uC5DYRafeDJlv9yog==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi. I have problems with my email account to send the patch serie  [1] to
all the recipients. My account blocks if I send an email to a big amount of
recipients.

Please don't reply to this message.
Thanks

[1] https://lore.kernel.org/kernel-hardening/20200906121544.4204-1-john.wood@gmx.com/

