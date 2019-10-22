Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81A59E0209
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 12:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfJVK02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 06:26:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:52463 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVK02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:26:28 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N4yuK-1hvC7C2U20-010ufv; Tue, 22 Oct 2019 12:26:26 +0200
Received: by mail-qk1-f181.google.com with SMTP id 4so15703093qki.6;
        Tue, 22 Oct 2019 03:26:26 -0700 (PDT)
X-Gm-Message-State: APjAAAVR6j32xQUPljneE53Igymhij+gEX0gIMHeId866gbHa50djBeN
        aiZT8P0HZCYTYEh5nLECHtUQWghcPVZ6HhAxnAA=
X-Google-Smtp-Source: APXvYqwSO1WMdUGQEJlTpMVP4JyNoKS32ISGEXZxl0XuWRKB/d7ZSQIo0HnbDgulrOldKwCE5M4KJ8mRxdWVTW/noF4=
X-Received: by 2002:a37:a50f:: with SMTP id o15mr1148094qke.3.1571739985400;
 Tue, 22 Oct 2019 03:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191009190853.245077-1-arnd@arndb.de> <20191009191044.308087-11-arnd@arndb.de>
 <20191022043451.GB20354@ZenIV.linux.org.uk>
In-Reply-To: <20191022043451.GB20354@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Oct 2019 12:26:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1C=skow522Ge7w=ya2hK8TPS8ncusdyX-Ne4GBWB1H4A@mail.gmail.com>
Message-ID: <CAK8P3a1C=skow522Ge7w=ya2hK8TPS8ncusdyX-Ne4GBWB1H4A@mail.gmail.com>
Subject: Re: [PATCH v6 11/43] compat_ioctl: move drivers to compat_ptr_ioctl
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9QYRekkZRmftZTpXqq5Ta7ySdGBrJGpk5Y3E2aNCXjVWZ9lbIgi
 H+hu3jkbbhmSa/1ogUFGNDHKjzlwZpfbs90MD+hX7EK9U1KbNwmQRfaw875JRI/qJ1Zs88X
 /+ny+r+I+eUKH7jiIyaFJmavCZy8dNCEFqWL3k8z+DcoGSPaGiJNMFtMQS5tfP70IvtQmFO
 ZztmTYLt2ZfrEXX3XbCcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iGCRB/uaydI=:M830Sz+8d9YgyULC754S0j
 oXZVneQZ3xqgBlGKCdhol75lDjRmRjQhCeT6uYMxzXwAVjW4CgUpd4AIAsi1qjBKFvdLnevmu
 6G0P0um5Jxlvd9V8Xo9oeiwAS1GqA1Eh2ezMKBnXTA62Kx3i+qJ7d0QQIWG7b0AomDNm8nDyj
 O/FeM2pQ0qr0c91Jnh1q6GXZ54okkyn5MEsTfNXBYalDMjp9Y8ZbKElB4UrGS8+T0Tkn9FAw7
 teAFTpdfY9aUyUaE7MvswQ803sAmdXjABTsBIJOC6RK0O430isAsjYPvWlPVlAKU0bISc5cqi
 QlbgSp7QOE+lw9Vz8NZC+UjnoF68kEzBkB2QO6xtkndc0UJpZ6ejaQ+avUMl4KDDQy0s+VYXa
 H06hRj67wb1rER9+Pj3nG1p6vxg4XdSPc71QZHs7bfVDUMLBKoFZqHif7hDFmZRmjKVhr5bCG
 7J78Mkl4zS9CcPuthzVP4y9ybv+6fewFK7rDgaRon/HG2nA8x2lYhW6T2heHpzNzybSqfaSGf
 kGX+WKI0gDFYCmDGVV9ed8s1IWM+x9qVAR6TYW2gRQPWoahepfOVmoQFl9L/lCf5utDFiE9lP
 79Q2qziF+WjU6WNSdUFCjBg6OXMbEFDKay3jkJNB6t6zR7BmZrxwgB9Nn0Cibh2BLXz5NHmWX
 MGuBEfOJs20jrRHJhVR7F+yPiwuhyG8fVBQa1i/bz/ccB/4jF+L/V5EwSniXxx5exPSQhzt6u
 Dkpm/ZjFtRqBwTbFW002+hnBEL4jhlNO/ssut0GHsGsWVDD7TDI1s/cwV5X29ExTAfrPvhsMW
 rN88xeH36W4LLO3N6KWQTdqIXGhzXDKYT8l1ZASCIkia7coy+WEFLdXPl80Lm3RGXkUyJsDlv
 9Au2gX55S7x/9bi+L+hw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 22, 2019 at 6:34 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Oct 09, 2019 at 09:10:11PM +0200, Arnd Bergmann wrote:
> > Each of these drivers has a copy of the same trivial helper function to
> > convert the pointer argument and then call the native ioctl handler.
> >
> > We now have a generic implementation of that, so use it.
>
> I'd rather flipped your #7 (ceph_compat_ioctl() introduction) past
> that one...

The idea was to be able to backport the ceph patch as a bugfix
to stable kernels without having to change it or backport
compat_ptr_ioctl() as well.

If you still prefer it that way, I'd move to a simpler version of this
patch and drop the Cc:stable.

      Arnd
