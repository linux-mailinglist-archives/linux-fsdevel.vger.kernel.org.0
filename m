Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C87E11055B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 20:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLCTl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 14:41:59 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:38002 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfLCTl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:41:59 -0500
Received: by mail-io1-f47.google.com with SMTP id u7so2617249iop.5;
        Tue, 03 Dec 2019 11:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTx5dc+vWRjXTXD8ea8S+IkQ3P+N6xf6FOFbA6Qu55s=;
        b=jrrHcgnhXUWgoj9+ZSOjgJb4brfKOYbkrKYb5diaLu/BTf8PmsF9/f8NgUiTa3fp0l
         XzePY0ugyf+vqzfzU9PkzE19EfYxW6QCFGdB+JvgZ1b2eQuVHqaiHIgcHL+MJt73E9w5
         lRRZuRcTvD3g8wW8Zpg9hYG1Y/YcvC0Jg1quqoERaus3ZRlrGUu9yAPvLdMowCXEAIjs
         HQSW6nbRr7B/3ZLqpS+NwPDCpzZ/BhoiGqyw+ESVx6r4S6pW9WXztVoI5RGJSm/rhtn2
         4TG8Lhny2xOLYA8zv0XVjsVkNJK4hzj1/vD9kCA+0RT6Mk0Cx0/A7uNoFQSLjJZOLRvg
         pZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTx5dc+vWRjXTXD8ea8S+IkQ3P+N6xf6FOFbA6Qu55s=;
        b=FWBd8fJ9YkIJc4Zy7Cx7YY5pLTKcS7iwECGRitkMilwGXYHO07iGj6M4lyL3xdYBK6
         CG3/yp6iiePZn519cctyPY7YD7AkB7A81Y/OQ09Yk2AeEeoezgeni3AOuJH+pSlYuovf
         0kuAjF5jeTQDRH0wxL8plIPVnuQflhhmF4JdoQoLZyKn601JJuhvnAw5fnxf+0hkaIxN
         OoauntegWvm41HmypTkOczmU80ftYgCHKod1oSFg+6r2LIVBRfKcQDxH3zI0rf2kS/XR
         Eq5Z++UhPl3Hcdp78vRwnxDaMvizAE8fSyJWtcyE0k2up6d1MKPqpBqpNGfmiHco4l8+
         LwLg==
X-Gm-Message-State: APjAAAU1nH89I+ethjioO0/Mc2QvPnbUWt9SlapJ/8IRIGPJsfnm+ehu
        0jzOkweRY98ikAiFkoA9xnuUqjeB3GQG3wwtABo=
X-Google-Smtp-Source: APXvYqwhSOEQxYU6Dlo/9b0oyJWmHuqP00+E4UBzSJdtpsbuP8z60EhXPjwWz94oxTEOHcz/vENiKFMUz0aJvvSJt1g=
X-Received: by 2002:a02:c787:: with SMTP id n7mr7202222jao.85.1575402118170;
 Tue, 03 Dec 2019 11:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20191203051945.9440-1-deepa.kernel@gmail.com> <20191203051945.9440-4-deepa.kernel@gmail.com>
 <aef16571cebc9979c73533c98b6b682618fd64a8.camel@kernel.org>
In-Reply-To: <aef16571cebc9979c73533c98b6b682618fd64a8.camel@kernel.org>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 3 Dec 2019 11:41:47 -0800
Message-ID: <CABeXuvouZTBnugzNhDq2EUt8o9U-frV-xh8vsbxf+Jx6Mm4FEQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] fs: ceph: Delete timespec64_trunc() usage
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Thanks Deepa. We'll plan to take this one in via the ceph tree.

Actually, deletion of the timespec64_trunc() will depend on this
patch. Can we merge the series through a common tree? Otherwise,
whoever takes the [PATCH 6/7] ("fs:
Delete timespec64_trunc()") would have to depend on your tree. If you
are ok with the change, can you ack it?

Thanks,
Deepa
