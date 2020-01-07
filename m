Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FBB133781
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 00:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgAGXjG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 18:39:06 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37597 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgAGXjG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 18:39:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so1805716otn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 15:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xMZkcHtFGlxtWMU0/yJi4CuOWPo2x4C+GD+Xd4ftxtY=;
        b=fGlV4Pr2MgSNzKMiDvbbOE+RWBOvNONUJBDPutDXvnKV0UHzXrxqy41oXKo6WrCibz
         nIRkrfWVWS/3omjTf2Szli0DI/W6lLwbaiIUY2Th1bSJbzbi5GX640rH874VzisnSJBN
         s3Goe8kx/MBl1KrfR/Q6Q38YPMR41UmkrW1Gd+X9IIEIxtYmHbhTJRqiFPcX8Z4JUIxo
         AbpigFkKiQOO5NhcIFROnexkKOwsN9Kh7HoEvk2zwnpTt8e9OmkfedzdRR1luOdVBsXq
         wj40LOEnqORt9GMjzv6fUO3xLP+gEY5sn5TmCNDBD42EaYbFnVTfd41qJspyjppYb7f8
         ISzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMZkcHtFGlxtWMU0/yJi4CuOWPo2x4C+GD+Xd4ftxtY=;
        b=QIorLuFuuPWI5TCwWP87/4gGVREIyvYm+uXWOzADcQ2iXf+mdPmKbbjVVzSyIO/kA6
         bxe2QlMN2s62kA8MOLlmiwKtrmZTHuI68g9oXxc6Y08yUGuojTBeZqmROTYkuwZWaWV7
         p26gMGM5BPjeYFxy8sPcP0tE/mEVTsQLAoUclOnTQmNjAf+cW+alh3KTxZmv4tTjJhFe
         9DCsLV0zq8BhkxSpILhM2HEYOuoalFIJebDZvcu4awkWVLJ1JIIAPj+ZxriC+scz0nGw
         ul57rQE3oM2pFbJ57JHXIaJUKFG3niVG5J7esWvSVzyi5RGL0OiUUmS4lSgS6Dr5VNS1
         Ytwg==
X-Gm-Message-State: APjAAAVVMdQk902i0YxJXb0q/2bZk3Vv7EfifOjm7dluAD2NBwtx/l9a
        sVcSXBFgCId+waSLrSSaTYc3YwNv2Vy8da3c4t06xA==
X-Google-Smtp-Source: APXvYqzvMVVYbs2feLkPKE0gtd4wuHz+YTqavAMbyJigJXY55hh1AQBdpn4tA6LqJn24ZzdQ5nOCMzZ/4ozWhNizGXo=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr1958301oto.71.1578440345524;
 Tue, 07 Jan 2020 15:39:05 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200107190258.GB472665@magnolia> <CAPcyv4ia9r0rdbb7t0JvEnGW6nnHdAWUHbaMrY5FKBY+4Fum6Q@mail.gmail.com>
In-Reply-To: <CAPcyv4ia9r0rdbb7t0JvEnGW6nnHdAWUHbaMrY5FKBY+4Fum6Q@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Jan 2020 15:38:54 -0800
Message-ID: <CAPcyv4jDYUPp=aqH1VTfxFAXiMa0Uqn+ykptfu_yNDOjR7Akfg@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 11:46 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > I'd say deprecate the
> > kernel automounting partitions, but I guess it already does that, and
>
> Ok, now I don't know why automounting is leaking into this discussion?
>
> > removing it would break /something/.
>
> Yes, the breakage risk is anyone that was using ext4 mount failure as
> a dax capability detector.
>
> > I guess you could put
> > "/dev/pmemXpY" on the deprecation schedule.
>
> ...but why deprecate /dev/pmemXpY partitions altogether? If someone
> doesn't care about dax then they can do all the legacy block things.
> If they do care about dax then work with whole device namespaces.

Circling back on this point now that I understand what you meant by
automount. It would need to be a full deprecation of /dev/pmemXpY
devices if kpartx dax support is going to fully take over for people
that want to use disk partition tables instead of EFI Namespace Labels
to carve up pmem.
