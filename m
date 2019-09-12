Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5CA2B10C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfILOMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 10:12:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43196 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbfILOMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:12:17 -0400
Received: by mail-io1-f67.google.com with SMTP id r8so29943375iol.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2019 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2jEDb1QsqevepCdtGya/Z1Hoe5KmOvpZIUb+tzy0XM=;
        b=qAyF1gfc2XLgWPdNN+uNXOErYtAROTxvSjSIWSeLv9dbc2rSX2QVNQJTRvvkY+f4zP
         /PDMieEcHude39r+jtjKNYwhvg/+xJmwORvdwUHfi1Fedd0Cd9YzENBl1pdykyd2RZnU
         SXpBBaaCdY1VlZVryNfe7tJidn1OvXpIi+2c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2jEDb1QsqevepCdtGya/Z1Hoe5KmOvpZIUb+tzy0XM=;
        b=uPyZvqOlho4YqyxdqWS7DC5sCqy5rHpNJI9aHuoi/O9olfr9xE6J+LZQoM/3T4ur99
         0EfTNwtsg2lf269eC20s5ChFkIqsRt84LBAGjc85CKR8m8ICDuAemI536hznw5pclLLA
         ZEU2b8yVsmI7xW9/hnew+51ESHDe9aO3K9LHHuM00PR+Qzm6cmVS+O4YMBskha/nsHoG
         z3ctzO1Ko9TcHYNiGO+B5C0kVJBscCMx1lr/c0qJGK7+X2YYiIfheCRexAAHRJJhwElr
         exjRY5b71Z2KiodlX2jUYl4cu1jwVN50On4rxE19FA2IwWH3biGWeGw+7xOLW1boZ3Jk
         d78Q==
X-Gm-Message-State: APjAAAUJcu6zo7kFv5TNbrx22SoCM/K0M0GRRBYP5oCajIlm8mwcPcES
        NNvpviSK6SyxZdQZ/YcMFEiH+kSwzUL+utK/EWMMnA==
X-Google-Smtp-Source: APXvYqx7aXVKjwtG8nManBSqWbGNQkn9aHInKjBA8WsbuzX4//8mA5DikAGQD5Xi2EEnGxvCyyxVbyXVjjfH2sUuy4g=
X-Received: by 2002:a6b:6602:: with SMTP id a2mr4431129ioc.63.1568297536300;
 Thu, 12 Sep 2019 07:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190910151206.4671-1-mszeredi@redhat.com> <20190911155208.GA20527@stefanha-x1.localdomain>
 <CAJfpegsorJKWoqRyThCfgLUyXiK7TLjSwmh5DqC8cytYRE4TLw@mail.gmail.com>
 <20190912125424.GJ23174@stefanha-x1.localdomain> <CAOssrKc=jv7RfzUWp-SoH7Bo-58XspSKpN1Asz-QMrA6wsVXdQ@mail.gmail.com>
In-Reply-To: <CAOssrKc=jv7RfzUWp-SoH7Bo-58XspSKpN1Asz-QMrA6wsVXdQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 12 Sep 2019 16:12:04 +0200
Message-ID: <CAJfpeguWB_6M1kr0ORQCvLgk3EQKxHisk0bQ2Os++dysfuXKmw@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] virtio-fs: shared file system for virtual machines
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 12, 2019 at 3:07 PM Miklos Szeredi <mszeredi@redhat.com> wrote:

> Is this a regression from 9p?

Let me answer myself: 9p seems to behave similarly: after
suspend/resume it hangs.

So added -EOPNOTSUPP + pr_warn() to the freeze function and verified
that this fixes the bad behavior.

Thanks,
Miklos
