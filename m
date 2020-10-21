Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0FF295313
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 21:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505066AbgJUTpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438786AbgJUTpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:45:24 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54D8C0613CE;
        Wed, 21 Oct 2020 12:45:24 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id j6so833262oot.3;
        Wed, 21 Oct 2020 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=v0iK/cV72UNiwB5XBenTai9sOdiim2LZ9CpHGg2+i4Y=;
        b=gtHnwaCCQDA7vrlBp6DaFMbU7Dy9JQ5t2J28uDXHa71Q3oPwKst66bkUxieJjipnmQ
         Pe8YmMcb9hVn4TB0kA9JY2exDGR7WubLdX3ofIEkIpmYYuYRxHPU6qdH0Bx3wXoLFuN5
         u7Zqbia33X+8YYerN1tQjTlp+yPSFyVv5TuuncpfZ2XFNcTybtL2mpDCBbEatMeLYBFp
         Wp4oLTFG7u9DJBrUR69FonpvYhZv97ZXzgLfmsQcmwQ4OtODw9cbxqQwct2M65Kg7eMf
         iH+cAxWsngb1P3pFDNPIbv95Uu7kNHVCoHJMn0xJNnpZ35M4qx4QClwnjkjDjV9YDMIq
         pTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=v0iK/cV72UNiwB5XBenTai9sOdiim2LZ9CpHGg2+i4Y=;
        b=dVnGKu6/2TmScXJFbsfwaQl8nIqNjXe43dsbGN0SXWfRCZE5hgnwFppejnpWNpvp3G
         BdtMZZRbv6uFyiiwrho2SS2kcu5xXwx4G4xzXTFe3gWhnDd3K2G3HTD+sz+3X50Twk+A
         wQh61C/Kueb9eqzKo/S3iDxa1qZsv9Q01jomFFQdi2syAcTbz6r8UtAt/3vd3YnmeIug
         Ssz0fGwfAgBilOEZ3BiqlKr4YnuGJhENPf2lK64n5qf2cL7kerSsUXFq1ybMOryQpigj
         QoIxiNjXHZLPEHfbjawLLChNwe3Bp+jqvJLdl4RnTsBBLnkzoewdMPl5TxDkxE5viD1c
         rf6w==
X-Gm-Message-State: AOAM533ENRWRaQ7rxvktIJJPYSrxrA5Xx4t5AqtKJj+6zaEXYUD2HZtf
        35sS8oSIXWze8Zic3r3WtkOMvxaRx5EZllZ0Xo4=
X-Google-Smtp-Source: ABdhPJzJL5CqKmGI9mY3iOQcT4fjT9UfTQeTDtRqkSxMQaxbob7iglOXLrVsz8WK7WSCXek9YQhYIFHLtdp8TDN3jkY=
X-Received: by 2002:a4a:ea4b:: with SMTP id j11mr3737030ooe.56.1603309524072;
 Wed, 21 Oct 2020 12:45:24 -0700 (PDT)
MIME-Version: 1.0
From:   Albert Netymk <albertnetymk@gmail.com>
Date:   Wed, 21 Oct 2020 21:45:13 +0200
Message-ID: <CAKEGsXR_ZDwydz2Ed3gvqCbnVA_vT3PZG0a2RLbgj5q4fP5LuQ@mail.gmail.com>
Subject: Imprecise definition for proportional set size in documentation
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From https://www.kernel.org/doc/html/latest/filesystems/proc.html
```
The =E2=80=9Cproportional set size=E2=80=9D (PSS) of a process is the count=
 of pages
it has in memory, where each page is divided by the number of
processes sharing it.
```
The definition is a bit imprecise if a process uses multiple-mapping.
A real example is ZGC in OpenJDK, as asked at
https://superuser.com/questions/1485370/linux-misreports-process-size-with-=
heap-multi-mapping

A more precise wording could be something like `..., where each page
is divided by the number of mappings associated with it.`

PS: I have read
https://www.kernel.org/doc/html/latest/admin-guide/reporting-bugs.html,
but it's still unclear to me whether a mail or a ticket in bugzilla is
preferred.  Since this is just a documentation issue, maybe a mail is
fine.

/Albert
