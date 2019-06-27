Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E6B586A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfF0QG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 12:06:29 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44737 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfF0QG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 12:06:29 -0400
Received: by mail-oi1-f193.google.com with SMTP id e189so1947153oib.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2019 09:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWIMvxomigHpjWeHK43P8bQp7hskbPyoEW4qUC++xwQ=;
        b=vp6g94SZAEhogB8+kASBrS83edW6InCqKko2xuhZZT36olRb9uNCLMVjLyfI6OQkYT
         8otOEjJ/wDda0iFu+AgKq5gR4ZQdNDsgl1cId5NnnL1iJ/GvZXT6HuisMcGOClqUlIDC
         FjGSCO8bQLXY3sOuHvTq/VDGJlZgYzKRP7eKLh/seOIB2ogk0e13lnG4EjwF37n71ps/
         zar5oshbh8IZ1AxD5brAYSbwVO6BQCN0DWQqcd2Fb8iQvPW8X62BL2WBnTS1MxzZQhxg
         ei8ENh0k8ProSrH8xiIDZSOUsBqFhCE5qcGcZDbva8PLP4urG/BUAIMh00/WAaoWm7Us
         XyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWIMvxomigHpjWeHK43P8bQp7hskbPyoEW4qUC++xwQ=;
        b=Jj+aOEvrd4YHAqwiIdMlrPNh42NXM22cdQIMLdKU8nn9JtJRQkJLCjsxFsdbXA0N1n
         bvZbJfvS6B1I4thXSHFMhm21WEb0KjPGBecXGZshxAJOKg0/lz5RJKMk6DorK+RE/AZm
         WFaO4Zn6cVX75iivAEeAJSQ9jEz/JRqtrRPtAD1wFWGsVMV1eM+5uP333CR+TbQumLdk
         qflG29hwVVRYCgYZU6hUSJNmdGmf4QN6LhWA5rIVRt3UKwF3w/kKmBfV/PijLSCP4gnM
         9WzMPbRGW0m51eFdS1zPfqnWAD37Kmt+SJFkx90Qm7FyXZMni+JBiyPkYgUVwdhbpnsA
         DlIg==
X-Gm-Message-State: APjAAAU3sIhKVBArBcz1HCgClEYytK+uUX18k/+1B+s6+pQHDSYzZCeu
        qcjqFaQgIAphkxclLRQgLZ4kxHUblZbpvy5/N0AAhw==
X-Google-Smtp-Source: APXvYqxTBH4M/fPCrgDrZ+VdGZm5oRMIwhu+eQ9E/gvhgkhPtescyRRgvt8+s9jNs39vk0crvfXTrVskZyRmmvNYxVA=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr2695751oii.0.1561651588356;
 Thu, 27 Jun 2019 09:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org>
In-Reply-To: <20190627123415.GA4286@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Jun 2019 09:06:17 -0700
Message-ID: <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 27, 2019 at 5:34 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jun 26, 2019 at 05:15:45PM -0700, Dan Williams wrote:
> > Ever since the conversion of DAX to the Xarray a RocksDB benchmark has
> > been encountering intermittent lockups. The backtraces always include
> > the filesystem-DAX PMD path, multi-order entries have been a source of
> > bugs in the past, and disabling the PMD path allows a test that fails in
> > minutes to run for an hour.
>
> On May 4th, I asked you:
>
> Since this is provoked by a fatal signal, it must have something to do
> with a killable or interruptible sleep.  There's only one of those in the
> DAX code; fatal_signal_pending() in dax_iomap_actor().  Does rocksdb do
> I/O with write() or through a writable mmap()?  I'd like to know before
> I chase too far down this fault tree analysis.

RocksDB in this case is using write() for writes and mmap() for reads.
