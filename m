Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0572A04E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 13:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgJ3MAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 08:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgJ3MAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604059245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNq2Zfxvzm57VdYBL3I2bff9Y+07X81lkXYsCB6Of6k=;
        b=YimsI4mKcsrQRCpTrwml7k5iF7XLx2JpHZMsEH7kekBc5gborJB7V0q9KuugNuznX+PU9v
        NkYKnNQ3smyeCz07/dKcij4m2u6T07NS5A3bQCgVMF7Lk0yBHbxZSnkyQ/1Ga0J0wo3qea
        1hdJ3zNL51vffGSWx4ZCvxVIbUIxqCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-T42lQ-NzP2iqpOaPm4nVfw-1; Fri, 30 Oct 2020 08:00:41 -0400
X-MC-Unique: T42lQ-NzP2iqpOaPm4nVfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB51110866C3;
        Fri, 30 Oct 2020 12:00:40 +0000 (UTC)
Received: from ovpn-66-212.rdu2.redhat.com (ovpn-66-212.rdu2.redhat.com [10.10.66.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E279B1001281;
        Fri, 30 Oct 2020 12:00:04 +0000 (UTC)
Message-ID: <8b57dd7972f54fcf271a5790696cbd6c950269ff.camel@redhat.com>
Subject: Re: WARN_ON(fuse_insert_writeback(root, wpa)) in tree_insert()
From:   Qian Cai <cai@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Date:   Fri, 30 Oct 2020 08:00:03 -0400
In-Reply-To: <CAJfpegv4jLewQ4G_GdxraTE8fGHy7-d52gPSi4ZAOp0N4aYJnw@mail.gmail.com>
References: <c4cb4b41655bc890b9dbf40bd2c133cbcbef734d.camel@redhat.com>
         <89f0dbf6713ebd44ec519425e3a947e71f7aed55.camel@redhat.com>
         <CAJfpegv4jLewQ4G_GdxraTE8fGHy7-d52gPSi4ZAOp0N4aYJnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-10-29 at 16:20 +0100, Miklos Szeredi wrote:
> On Thu, Oct 29, 2020 at 4:02 PM Qian Cai <cai@redhat.com> wrote:
> > On Wed, 2020-10-07 at 16:08 -0400, Qian Cai wrote:
> > > Running some fuzzing by a unprivileged user on virtiofs could trigger the
> > > warning below. The warning was introduced not long ago by the commit
> > > c146024ec44c ("fuse: fix warning in tree_insert() and clean up writepage
> > > insertion").
> > > 
> > > From the logs, the last piece of the fuzzing code is:
> > > 
> > > fgetxattr(fd=426, name=0x7f39a69af000, value=0x7f39a8abf000, size=1)
> > 
> > I can still reproduce it on today's linux-next. Any idea on how to debug it
> > further?
> 
> Can you please try the attached patch?

So far so good. I'll keep running it over the weekend to be a little bit sure.
It was taking a while to reproduce.

