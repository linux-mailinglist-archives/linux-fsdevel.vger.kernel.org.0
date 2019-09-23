Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3DBB198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391834AbfIWJpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 05:45:25 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:38031 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389262AbfIWJpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 05:45:25 -0400
Received: by mail-io1-f54.google.com with SMTP id u8so10515288iom.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2019 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44EOEm7yz0oFG+vheu1aHwVYo1HpDuXq6px8EByvfPc=;
        b=pU4T85jjQHoJV3oD9AWVMWGf12n9L6ApRhOca2y46BeVwOmskUCrUooYRj68YoUKcS
         QC5Uf8USdwzZxwWHF0vJ85KTujKf1tFE6PjbOqE5nZ6P1QVAjCvBT0SRjPUXn8RkC6sC
         QZ5bstTnOS92F6b65gGsTkcSO7g2Eu3DvtmX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44EOEm7yz0oFG+vheu1aHwVYo1HpDuXq6px8EByvfPc=;
        b=d1SQYElAKtbbyk3FQ8USMhs3o9aPUacoB8qb5vpm/y9I+PpsbislNjS9g+yjgBBQy4
         DsBNha6EF5BNCOcXHX20b5KVBEYt7oyHEZcLstbO4f/oOSd4cEXSe4ioNQyJlxNmKAbi
         RksTMrW9yr1rZ0M72enAfXiLY3sc04P4IiRIeWPB4QOSliI+ozQmiUR+CqszJUELXTXQ
         boR0UWvEzLeErr5mMIGL8C1VuNe+tuQRRnR8/4hpE70W9E+kJuiUX8Byu21PUgt5XkWX
         Jw6IcIQwLkSWGvaqvQs7rOUmFSBacrXDQXh0NvZRgp+DypA1/ANn5/46ThZSST3sslHf
         vNNQ==
X-Gm-Message-State: APjAAAW+w2+StdPzWX5Ri6IPYh5My2ua354DC4LWdrJtpfexAbsXpzuE
        vpueFExfm58o/PUUTxdzvYebQvNSBCXmHbOaAz3tf6VF
X-Google-Smtp-Source: APXvYqwguBWvgHxLYx37Mt9hw9WURFWYERqTZpIFrikxCBZgtfE2YeigIK8DqlQvIp2Fr1D4afE8LQFArub6coM6gqQ=
X-Received: by 2002:a6b:b243:: with SMTP id b64mr17114286iof.252.1569231924903;
 Mon, 23 Sep 2019 02:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190923055231.19728-1-yuehaibing@huawei.com>
In-Reply-To: <20190923055231.19728-1-yuehaibing@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 23 Sep 2019 11:45:13 +0200
Message-ID: <CAJfpegs4GzCHw-t4FssF=YNEByhFt3nTeidV+Jfoc-Q-KZ11-A@mail.gmail.com>
Subject: Re: [PATCH -next] fuse: Make fuse_args_to_req static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 7:53 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> fs/fuse/dev.c:468:6: warning: symbol 'fuse_args_to_req' was not declared. Should it be static?

Thanks, applied.

Miklos
