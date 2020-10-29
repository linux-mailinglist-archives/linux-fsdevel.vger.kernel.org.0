Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7829EFF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 16:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgJ2PbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 11:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgJ2PbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:31:00 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F4C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 08:21:07 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id r1so1698608vsi.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2vNhDEm3HbJWwlXQvfrqMnwz+Y6hXypKtoqXX91090=;
        b=ZeVFlYxbfCuY/CTkTlqJNy9tAAAQX1+083ZdKCIa7x1FWR21+Plm1CPrBsd03fL+a1
         9kxhuhqHA5xuykUmXmhTjs+dynTESM5EFHJjUSvzEMHqzuKqmcs6r4xBJiNaMTBnPwr9
         M9dts4aQTunZ21ku0hMwe6NKyEo9QpURz2Z28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2vNhDEm3HbJWwlXQvfrqMnwz+Y6hXypKtoqXX91090=;
        b=bvU+EQPxYxfTmDrqRlUbaUyHOluVEzANGObwsK8JCneO6MG+wqFFop3Z2TNN62ebIJ
         kQuLSw6SpgtahBtDZ6Fq+FG75n4f3+6wxPr/WAgyguJQ1myvTUt/vllvr0su1F3UsZv7
         kRl+uboMnAomFRVYK43AjUx/DZruz+R5lzVRqoTlciQmY8pAwfOQ5uhNDmsg7ILOCReD
         v9VedZuKF7Dsnjjm7ZIn2J8lLVLAnu+gZk6a/oTxcO1zSkzejsH+JF2NjOzUKJp6AslJ
         yN7tLiyfgO+XF5+/0uT5YbDA+Txo1+IJF05CAiyNBh7Yc1e2rHUDF3JX77ZOLesT6jfn
         M9kg==
X-Gm-Message-State: AOAM5317yup4iBZ5ZQJD4KTjBOzETp0GuYbD4q9Dmh62mES7kn4Bw6UI
        xbIqqLciL05NPieaEWgeuTjqj1Fd6nEp1zrVU2YN8A==
X-Google-Smtp-Source: ABdhPJyPUNHkn7dNetro3OoklJYl1bWTjUQtaDqS1cgdmcB2snVQpIK+qd+2mZzS1qZQtfW6kHTw+C8nB2PbP9ucmKI=
X-Received: by 2002:a67:1442:: with SMTP id 63mr3605467vsu.0.1603984866514;
 Thu, 29 Oct 2020 08:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <c4cb4b41655bc890b9dbf40bd2c133cbcbef734d.camel@redhat.com> <89f0dbf6713ebd44ec519425e3a947e71f7aed55.camel@redhat.com>
In-Reply-To: <89f0dbf6713ebd44ec519425e3a947e71f7aed55.camel@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Oct 2020 16:20:55 +0100
Message-ID: <CAJfpegv4jLewQ4G_GdxraTE8fGHy7-d52gPSi4ZAOp0N4aYJnw@mail.gmail.com>
Subject: Re: WARN_ON(fuse_insert_writeback(root, wpa)) in tree_insert()
To:     Qian Cai <cai@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000031f1b005b2d0d437"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000031f1b005b2d0d437
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 29, 2020 at 4:02 PM Qian Cai <cai@redhat.com> wrote:
>
> On Wed, 2020-10-07 at 16:08 -0400, Qian Cai wrote:
> > Running some fuzzing by a unprivileged user on virtiofs could trigger the
> > warning below. The warning was introduced not long ago by the commit
> > c146024ec44c ("fuse: fix warning in tree_insert() and clean up writepage
> > insertion").
> >
> > From the logs, the last piece of the fuzzing code is:
> >
> > fgetxattr(fd=426, name=0x7f39a69af000, value=0x7f39a8abf000, size=1)
>
> I can still reproduce it on today's linux-next. Any idea on how to debug it
> further?

Can you please try the attached patch?

Thanks,
Miklos

--00000000000031f1b005b2d0d437
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-launder-page-should-wait-for-page-writeback.patch"
Content-Disposition: attachment; 
	filename="fuse-launder-page-should-wait-for-page-writeback.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kguz5cjv0>
X-Attachment-Id: f_kguz5cjv0

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZmlsZS5jIGIvZnMvZnVzZS9maWxlLmMKaW5kZXggYzAzMDM0
ZThjMTUyLi40MWIxZTE0ZjM4MjAgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2Zz
L2Z1c2UvZmlsZS5jCkBAIC0yMjgxLDYgKzIyODEsOSBAQCBzdGF0aWMgaW50IGZ1c2VfbGF1bmRl
cl9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQogCWludCBlcnIgPSAwOwogCWlmIChjbGVhcl9wYWdl
X2RpcnR5X2Zvcl9pbyhwYWdlKSkgewogCQlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gcGFnZS0+bWFw
cGluZy0+aG9zdDsKKworCQkvKiBTZXJpYWxpemUgd2l0aCBwZW5kaW5nIHdyaXRlYmFjayBmb3Ig
dGhlIHNhbWUgcGFnZSAqLworCQlmdXNlX3dhaXRfb25fcGFnZV93cml0ZWJhY2soaW5vZGUsIHBh
Z2UtPmluZGV4KTsKIAkJZXJyID0gZnVzZV93cml0ZXBhZ2VfbG9ja2VkKHBhZ2UpOwogCQlpZiAo
IWVycikKIAkJCWZ1c2Vfd2FpdF9vbl9wYWdlX3dyaXRlYmFjayhpbm9kZSwgcGFnZS0+aW5kZXgp
Owo=
--00000000000031f1b005b2d0d437--
