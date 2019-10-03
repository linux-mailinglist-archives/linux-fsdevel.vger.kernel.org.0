Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558AAC991C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfJCHos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 03:44:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36555 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfJCHos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:44:48 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so3342428iof.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaUQp3o+BSRmsrzdEguRbkxjtBp53X0GcJCQG0oPhZs=;
        b=Zl0vwxknNRraHL4fR/MtdWCxd1z+5ANtUHSyaiGgeOhHI6ER4m3SRrcKExnpjM9zf0
         N5I3+0me5WscD0aTB54XZPh4fvmGGrDAUHaywZWp2CRdxB09w+PmqCwUHO20291rfX+K
         94IifWqoiFc3WCU5M86h7zKY/z42I5oYiYoZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaUQp3o+BSRmsrzdEguRbkxjtBp53X0GcJCQG0oPhZs=;
        b=JKJ7Zop5+sHUyzInXz7EsfkMnrnVbXl8vZU24kXTF9ZHvLD+fGV0SmaBvn7FHZzyqy
         k7DKsohw2ZEhIjVY0YmiVVo6PndsJrlFLDAfaerUb/kFqZFr7ab/1gYOEIovY8HjwjPR
         hSZnyQDeUYSZNMeQefyEgTvcMatEKAVc0t9Jq8ZgwVg5EbfbiWT6PR3acHGoB7yNsxdG
         40JEweLFFQEbC33czOrmqNYXYwA5CszpMkUi9mqA0YlRrjxMY1AGZ7nlHWcqq+hWT/8W
         KjEoqXJPVWcUtcWrR0AhbgJQfVPBt1WoJdP43Ua/Rwv7At4RYnrQbqvP9p5Xhc4YwPO1
         IMHg==
X-Gm-Message-State: APjAAAV37Qrr7rsFQeYvi6PSr5FQKLAME63ULW5E53olm7AJ4CxsVMUd
        R6kbZdda7BtU9KM0o08EVXzrUEIDGtZvhouuwh94aQ==
X-Google-Smtp-Source: APXvYqyFVfz8lXgjhdM3XrHJGSKkZDALs4ihuHBQ2hLgWx5UzaLpyh3NFZKqGukhIpW5E98Gt3jalc6iyeWA+b1qOE0=
X-Received: by 2002:a5e:d70d:: with SMTP id v13mr7320639iom.174.1570088687354;
 Thu, 03 Oct 2019 00:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190819171030.10586-1-asomers@FreeBSD.org>
In-Reply-To: <20190819171030.10586-1-asomers@FreeBSD.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Oct 2019 09:44:36 +0200
Message-ID: <CAJfpeguVTY-uBM5MW-80JQEFv6zgQXpvQjC0OJmB-EQ-e14wqw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add changelog entries for protocols 7.1-7.8
To:     Alan Somers <asomers@freebsd.org>
Cc:     linux-fsdevel@vger.kernel.org, Nikolaus Rath <Nikolaus@rath.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 7:11 PM <asomers@freebsd.org> wrote:
>
> From: Alan Somers <asomers@FreeBSD.org>
>
> Retroactively add changelog entry for FUSE protocols 7.1 through 7.8.

Thanks, applied.

Miklos
