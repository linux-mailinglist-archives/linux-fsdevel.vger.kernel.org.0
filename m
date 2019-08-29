Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC69BA1BCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfH2NtI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 09:49:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46298 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfH2NtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:49:07 -0400
Received: by mail-io1-f65.google.com with SMTP id x4so6908225iog.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Q3HOIVTiQQjN2WQrPLYQE1BmRGFiieaz+rA81DvnjU=;
        b=ZZWD9OpNRL0XtYFi2lFZlHxSZinqyJ8TpyLRrYC9iPu82pocpeGILmNJueXE79tL46
         Hx3iIG3SHdJuf3SlJEy1VlbhChjRlBUg7MhHjF0H71LlBWYxfvIQWax+sVjsQt5WUM/v
         VduNLbytEHMvZQWgrRu0W2b2t0rKniNs6zLPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Q3HOIVTiQQjN2WQrPLYQE1BmRGFiieaz+rA81DvnjU=;
        b=sa9cfXfKLLwHD2M3T5GpEKi67GEipeBevTDMKhzkmOxbHIhP020aBk9KNqZzmDcjXQ
         a6ca/tfJjGYh13Bgjx0vvAq80cKqNdUyWUiemNd3FuJn5RXiJ0fNHbZzzeOmzlLTlWon
         0dP4WzD0bgwfpj5cGmmK+FKbjZsBJFY9hKOlpA9ZhiD2dEfJO46tUumBqZ+m1Eewk9Vp
         jazfjoAyos1QoEVghk14CU6jBvsukQ5FAxGJXM3wkKuldYSa5tdONq+i96koIzXtApGx
         7Utp9G4FvC0GbXjsmLJ5Yb+aLdcYQDk7Mxh8e/NVF5FI+0NeTX/6cI4BTbXIfaf+0wLW
         Sqog==
X-Gm-Message-State: APjAAAXNhAmoCUSMQbk7aZHVKCdSbqH/IMwm5neppPtUcMGDmBkt1hNS
        8ydzVdjvB2rnVVDRlkYw4yfnY0ReO7SNVRBYeDd1rw==
X-Google-Smtp-Source: APXvYqzW2n25R0aKrJKpGkCfaBBX65DnLGmBlfFac1mmX3iIfD8YBhimr86nLnQnYes5p3+3pE+/AtLQSkscAssggNI=
X-Received: by 2002:a6b:da1a:: with SMTP id x26mr11000610iob.285.1567086547127;
 Thu, 29 Aug 2019 06:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190829134104.23653-1-stefanha@redhat.com>
In-Reply-To: <20190829134104.23653-1-stefanha@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 15:48:56 +0200
Message-ID: <CAJfpegsMwGLryccnOR5a0RTFKjv3jH4g0DQt-HpkSQTwZgHyKw@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: add Documentation/filesystems/virtiofs.rst
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 3:41 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Add information about the new "virtiofs" file system.

Thanks, applied.

Miklos
