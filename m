Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA442145B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgAVRqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:46:01 -0500
Received: from mail-pg1-f177.google.com ([209.85.215.177]:44420 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:46:00 -0500
Received: by mail-pg1-f177.google.com with SMTP id x7so3881572pgl.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 09:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:in-reply-to:references:mime-version:content-id
         :date:message-id;
        bh=4zjg3BpS3HsO8Sv9usbzkTc9nEao6dmiGuMd91ExXQQ=;
        b=JUDaqy5lDC+7D2VM1hGyAah26XcxbTfIFhQLBvV2QxUWerDEE/AwZe29gk18YQcvFh
         7joNvJjyA2vuS6A2qzfAJU9u6y0UJdMgBC31qc7GniJi/mMxV218CIBgoA2XWz96k7Nf
         XzMV6b2gySkcc09etzo9JtEv0IC0+jc8WrP1Kz4WuwNzV2VOn/N/Q+Xuqb0R2Fh0O8+A
         OE5Zovq1vY6lbz/IbMvqQkhQ8mVq3QolST1/joMKBfGv1W0/080m8xXKuaZycaEVGAW+
         UwhDJM+l2ZCH6ykrmu4bQuWzbgv5Ae8rHowK5LJO4pbBdh/XR4pvl7eJtinxerdHgFRZ
         GQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:in-reply-to:references
         :mime-version:content-id:date:message-id;
        bh=4zjg3BpS3HsO8Sv9usbzkTc9nEao6dmiGuMd91ExXQQ=;
        b=jTet2LMfgt+VVBDzVeAsznq+7TJdRCyCyJZzllRY/kYl1lZ9Vfm7N6oRcSOdVFMjM6
         5CjjVAnIZ+eRliurh1Aa6HUVQ5PZFJUvX8pO3EOgZ+umBhfO1CS/9u8+rB9RAuyiSQaL
         w0xfw69wHp0lYN223/06Tj6wkSFCeVHqu5CwPWyopyNHNXa0hazrjB0C0p2sr03Yq3f/
         x53QUCv+P0Ki596ga3jHK9+vtwxmsmJSLbJ8hmZhmkQMbwXkAa+nHnogVlIljuezx+n7
         12GlDHuyW0U6kEHwpV+ONUG2FBy6qTbXgotre9tkxRP4RhrVoRBhxRdfKW43GZbL20zv
         vazA==
X-Gm-Message-State: APjAAAU9+IzAWksCwC6zFSSz9iHx7D+2nnaONdxoQ7FdAbxZFPnkoKD/
        LrbKtX7nz9oCvHgeNK/B/kE+hYcp
X-Google-Smtp-Source: APXvYqyOFEc+Ecp+I5Cd4EjPZxROrLKdvn07xW0gK0IfCRfecE7wA9NhFLl4GitGzgS/4Da6GmxOPA==
X-Received: by 2002:a65:66ce:: with SMTP id c14mr12723610pgw.262.1579715159763;
        Wed, 22 Jan 2020 09:45:59 -0800 (PST)
Received: from jromail.nowhere (h219-110-245-151.catv02.itscom.jp. [219.110.245.151])
        by smtp.gmail.com with ESMTPSA id t30sm45853783pgl.75.2020.01.22.09.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 09:45:59 -0800 (PST)
Received: from localhost ([127.0.0.1] helo=jrobl) by jrobl id 1iuK4i-0001kk-TS ; Thu, 23 Jan 2020 02:45:56 +0900
From:   "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: Q, SIGIO on pipe
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
In-Reply-To: <3574295.1579702923@warthog.procyon.org.uk>
References: <17045.1578548716@jrobl> <3574295.1579702923@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <6737.1579715156.0@jrobl>
Date:   Thu, 23 Jan 2020 02:45:56 +0900
Message-ID: <6741.1579715156@jrobl>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6737.1579715156.1@jrobl>

David Howells:
> Do you have a full test program I can look at?

Here you are.


------- =_aaaaaaaaaa0
Content-Type: application/gzip; name="a.c.gz"
Content-ID: <6737.1579715156.2@jrobl>
Content-Transfer-Encoding: base64

H4sICB2JKF4AA2EuYwCFVW1v2jAQ/pz8Cm/VqpRmhU7TvjAqdR2t0FAyEapu6lCUYodZSxwUm25s
5b/v7pxACKv2BY7zvT3PPTbuERepVILFN8FtHIW3k6uh6x5JNc9WXLD3eq272iTm7PtFy2vWS6H3
3YnWomyFirJUxb4rnSuT7buWRdbyaLlQScu3UlIbbn0p6/1rzrQ1UiZzaVo+qCGLA1cmH9q+UqoF
+YTiMnVdbCDnTCrDEs7TzEMr5X7tsYYqYkvEifvHddADHPgszZKF7ruuQwYbMKLBw/Tr+GY4vR6f
9F0HQltHER5V6ewJ22Ac4PdeNDo5jrW8F1ABA0phVqXC1n1347pCrXIG40yGlx9917mbjKZD+A7c
Tb8JyyxMjG1LkfD1fTDbHj4WkjPYiSwING5nlfvkUWkRG9bR0rdRnZVaacEJfbe7BBJN6r3UEgqz
V/ybeolpry/IgZPuxTwkirPer1fZr2YgemvU21w2GFTzniCy5iFVOWbe53A8HgXAGhqfJ6MTJMqx
4JCJ2ekpVHVEpgU7TMek8HbayCHabNIGWW0wx3EXazWvNLG/ewkJWsvfAojS+jf8WkoONnziiSlX
c+I0mRtZKKYT0ABCOtNJvHU7A7sAvzogRYAzuoyj0c0ouA5ZtwNY4fdkGE0vJ1PW6ULwBkVniUJp
UUe5EPnSrLUw3rFOsFqe6B92G9iQ89aRz7BHuJPodiyPDnwGwT4Lbsck430xElzIWQgDhveszsO7
wEdODiv8Ox46N+ZqZdgbirFhHITBh3F49QnYCePL6Gtw5QNX2+vT6fZoSlgNNPlZSiMo8Rgkfd4o
TecD67KxKIv/hUJsJsTSo+O0KJknIbPXZ5K9Z2/g6/TUCnh3Eaza5MyvL0ztwBJ1i9q3HQkEeXDv
a22BUOFj765rmS8zERdLobz596RknVQlubCPGInLmnnBResp4/SO4Uopu8oL48nHuwlwXCVTYnVr
IfgCQFug1TJxFkueNk1g9QY3OzjYcf++pTItmmM/O+Hr86188h+q4PW0UTy6HsGdeWK9d2/foh64
eLRKsK8r5jw9MfoDQ46Hwy+jiF4DqtukryrZ7RByKII2wq/qVcBqEvoHwIjnRCp6PZJyMfeZxQb2
4/3sEJzTgE5Q0YCpKP581q/AE0uWn90YgDxC6J42Z9rEtKbdHds+ZPQ6twX1F0EeFWowCAAA

------- =_aaaaaaaaaa0--
