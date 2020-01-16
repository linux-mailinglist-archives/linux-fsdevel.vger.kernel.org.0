Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A210913EE9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 19:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395111AbgAPSJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 13:09:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37041 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395108AbgAPSJ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:09:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id k14so20252715otn.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 10:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzuZRenN/3UczXLj3+thO7tKTqsTx9weWp2ttaG3+Ko=;
        b=zawuOQt5P47InN/xf28+hOOPRs0JqfEPg7d21bnyv89wscVYKmezFAfp43eeV4aj1z
         amFHw66rURc66/hjqx+kl6xxu+bxKSxkeEHWHRlL7UAodZS4USBNj/I1Y1mC8w76qAPe
         oJPFMagtBnvN/9TXG8ZOcyPhNz9NfaMSlmontOpFUyjwa9D5ipU4d2BAQTFZtbYH0LO8
         AsAKOyhzVopHd0EMrUJCO/LYIHUuDEZldvlymyKTVB297Erz7EZ9RyUbVBQeAe7/Ja4V
         HC9yWT8qYYbgQJarOSQ/z9QpA6XabIQSANO7+YXGXik4Wuxi4b0InRmGg+tFAxyTAk/5
         dK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzuZRenN/3UczXLj3+thO7tKTqsTx9weWp2ttaG3+Ko=;
        b=O+dqDXg+XJe6Wk15nPnEVGIK4GPbx2/xDwK9UGv014PD4wwxRuPD6rS/70X4pnHlwE
         84HXQiUkOsVHOVq8kb/r0YoyhvrWULshKCDzQczY6K77RKLCUdmbUJwAo3BLLYmxko8r
         aVGzIRj4goGL98AzKgVezeYDeo9Rx53YCPRXV5+zLg3xCu1TOX7CL/3Dwgl+BNT0gk7D
         NyzIx86tgKsP2Ownc3FwdOUHjo1ujJFkcIEJcq0eY3etc6HFjCDt7Ak4NVMQgbel3rgZ
         4osLjuWvIFqYk4VW7oaEsk5dT7rZLAPwqrTSwk1votvMXqG0nF7fVsRhS/zCTiUkjAir
         KjPA==
X-Gm-Message-State: APjAAAVgntq4lpFEOdrJrermIWCSw4f2mw4oSyQq9jUiaOax+yPcTkJG
        HF5prCjpYGBTC6hZ58UEnsK+c8ST2mn8nyq4S5YEjQ==
X-Google-Smtp-Source: APXvYqxAe2+rFr7S0FrSp08rIPwAe1Wau7z51hUUxL0cS3xj2Ecu8Rh56J0DxcLVUk1gryZFW39U+zJXoh6ArDNKXCE=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr3043119oto.207.1579198197588;
 Thu, 16 Jan 2020 10:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com> <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com> <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com> <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Jan 2020 10:09:46 -0800
Message-ID: <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
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

On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Dan,
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > I'm going to take a look at how hard it would be to develop a kpartx
> > fallback in udev. If that can live across the driver transition then
> > maybe this can be a non-event for end users that already have that
> > udev update deployed.
>
> I just wanted to remind you that label-less dimms still exist, and are
> still being shipped.  For those devices, the only way to subdivide the
> storage is via partitioning.

True, but if kpartx + udev can make this transparent then I don't
think users lose any functionality. They just gain a device-mapper
dependency.
