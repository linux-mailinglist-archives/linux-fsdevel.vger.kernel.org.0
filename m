Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A761859FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 05:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgCOEGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 00:06:32 -0400
Received: from mout.web.de ([212.227.15.4]:39191 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgCOEGb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1584245189;
        bh=HdLFlDSiunmZLz8UmkFBV7065Ixh+TtC49xQ5nbIsFQ=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=OVCxXBZ1UZGItJipGMwHdwz/KZfHlb+9zjiFtYPp0jU0hbHVMeyUFs1j/yVZS9I5v
         YAuPRa8Cklf/l3j0qVI7qz97gOemakCYVZJ4w8AyfZnBu5nOkYE9icgOSdqTVBd8ja
         Rji4xNFCGzC/xHaI+2kUa+C9WtNpwh2WOekDDCyA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.54.194]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhhVB-1ji3xG23yj-00mpKE; Sat, 14
 Mar 2020 14:32:55 +0100
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vasily Averin <vvs@virtuozzo.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fs/seq_file: Fix a string literal in seq_read()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Neil Brown <neilb@suse.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Qian Cai <cai@lca.pw>, Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>
Message-ID: <325648be-032b-8b50-f4eb-a2cebce7a475@web.de>
Date:   Sat, 14 Mar 2020 14:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xMhJtxirun74hKfeOlNQ5wIfe5q6n2vjT62QHATZ4cIvqmdUKgb
 04g0gADqC5CmUeay7gPJ2MufPBDco/7a6RfMBKIThptZvGOPk9+OjA2EdQ1LPEq/pcBbzg2
 BCJCTctp7BN6SPNqfElm7KTf5a173zvBiteuuRVEAinMOWzZofI47x+5/bme5UrsKR27S13
 8D/YxpdFsosBT5Fai7H4g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K5tOLvFS2j0=:kMEpmM+YYAG6i4Kyhi4F/k
 Ziet1Ji9BzJ4+YXLndegFoiGFIrIJSIaykcMunWQ1vt5kfCaWfv539TpNqkTiShK8LnqEmrOe
 qNv/SstK2TtDTQGAFHhnAiCP1/py/LHkEppFBZSwApz3gtfqX1TkkLSJXYdi0houlhf0uLlp8
 p6jgoeVQ9hssZwGIK6hijFxnGRAz5QhEK3fZd+zVGmiW75VqV3YvTD0wEMDjZK6FNuSJgU+nL
 0PP162y3kdyTEbhkuEuAyMf+xidwUZ4caxyD/UZHQydgU7oVGpeukR1n5gZPGV7100CKTU8hQ
 pk2/RGXBnPFWcT6Hgx5bunzrP/OeK86PyTO72CXeWpHirtZRlzGqrmcZdGI9vqNZI9/UWGVqV
 UwPxvUJv7CM2jIamwZmT8n4MD+8LNfB9HaqyIaiy+k/pKspUU1+Q+Qsi/wiLXkyzZYPpClh7a
 ukEPZ91wNxg0w1EG6zWndfWqttzC4H2/k6xE/vOd0bydeQAOE01JJZyXiPqmD8iAwBAio88mS
 w7Wxi2Gx4ZJIi3hx6z4liDnKeT5x2Z9ZQoJSnXJ8adO1CpI19VFFHTjW7FgEkife730MMuoU/
 mTkZ7/jwwgrb/oTwSRQ7E1EKyeqvEZDsn82yLe0Bn3khrTbELv2uk9aMBYqM6Pf0sfXyLoWvm
 Td1ZtYI1rEVBsscK25TNnahnJ3gtqqlgwZqJgJX3wkssRxVld8s/XK8w0o5f60dsLhqgplyZ1
 UFful7fWhQ1WepDQK/L7FNfQP8uJMBwnvzsWVwdwThbkXQhGjy/GhWjXhtHi6YYiJwbdt6P+l
 HJW8a4yilNEX2mSngrVfAabn+6nZ0irgjRtBk1LX0OkDhEXfugr+dritXEy9AaU+pIfGa/lXd
 I5AZTb21hfQtRqef008XEMW/bIYwpvHo4CccAk55qL8wj6wF6RcLbKeCL0BuQUpJ75PcAx4TC
 Kk1L+emHsoihlFeIyPJjYrhOT1CAhWzoXnNLSN7AZ9vfyj7QrT1BKi7ShwiDSp5c0S++jJga1
 uv3Wd17tpSI6rG8KXOYjNUPeHTIyyLS5CEgOO1KBhJBmjLyRsWIAo0/EJ3AReIYPqFacRHyXP
 8gzKuTX4oJbSE21+phnVfMy0+V2CeuRd3eLl4MGIHFAgNwPpLgH+0AwJ2FKHhA4EuTOA2jaXu
 o/2BGBMjWm62qegoxwug91UXNicHc8IwqyY9+CUUHIrUOPRTD8KfqpqJzwwjnqXg7godutyhJ
 IyfTiQYkfSQ8hX+o6
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 14 Mar 2020 14:14:19 +0100

* Improve a message a bit.

* The script =E2=80=9Ccheckpatch.pl=E2=80=9D pointed information out like =
the following.

  WARNING: quoted string split across lines

  Thus fix the affected source code place.

Fixes: defeadd3551c5565fbc76c97d6e99378b8acb1bf ("seq_read-info-message-ab=
out-buggy-next-functions-fix")
Fixes: c828e17c5312095fc25bbe78b16e97e99af72b9a ("fs/seq_file.c: seq_read(=
): add info message about buggy .next functions")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/seq_file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index d2a3dc5b9f3d..85cee24d36e8 100644
=2D-- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -257,9 +257,8 @@ ssize_t seq_read(struct file *file, char __user *buf, =
size_t size, loff_t *ppos)

 		p =3D m->op->next(m, p, &m->index);
 		if (pos =3D=3D m->index) {
-			pr_info_ratelimited("buggy seq_file .next function %ps "
-				"did not updated position index\n",
-				m->op->next);
+			pr_info_ratelimited("buggy seq_file .next function %ps did not update =
position index\n",
+					    m->op->next);
 			m->index++;
 		}
 		if (!p || IS_ERR(p)) {
=2D-
2.25.1

