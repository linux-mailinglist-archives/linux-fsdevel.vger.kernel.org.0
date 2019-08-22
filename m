Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34FF995C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbfHVOCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 10:02:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42357 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbfHVOCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:02:18 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so11980932iob.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1D/stRInaG/B0oiGaQ/Y2em5iSkjBb4j7/1WQmQSPlk=;
        b=kX1t1pYVzDBtynIeNroUD+4pMZ+Sk7MQpN01u5fmTOX37BYSYS25U5qhauO+bU7vaD
         RNGigmtEuXj1wGLyFC32YIYBySSbD2EwU26/0HRM18LvR9BsE8UB3Va8SyfNvEYzdNhY
         l2B4zj1oReaTshSU2ktuvvzIczvOyoxH9kMN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1D/stRInaG/B0oiGaQ/Y2em5iSkjBb4j7/1WQmQSPlk=;
        b=OBdbHnS8JWFwloB+42l+FpCGOLUCH89nM3+BgoqiLKyarUgPU/x9l1cvcz7gJwVfCE
         vzsF7rOwcz+hWE5lIRsrPwcik4kZChhnDpMkvD83S7Rf93U+QjDMeCWkMRSoV7hMGReJ
         pSqG+3d9a4FneBQmOKVH2eq6Qp4OGmmzqRtQkIi3ZK8UsXXIJBsShnXyJZImb11prlSz
         IrhGQQeylKIXhA/BTvGWFjl92imNB4onXcrrvclyINx5XAjYfzpIZIGn5ErwVhVUfW0f
         zTx2kGz4c4ytJTMdoYu0lxxa8QPM81cRy+UeFV2pGramkOaiJeEGFZHda3bPGVU7/Seg
         QJuQ==
X-Gm-Message-State: APjAAAUPseC20n3SBjsmFcQMSipVbaBTZGhap9WVzieHQIerCF4H4lnC
        bQel9NdP43n5h/LlZQUK+aTaG35HQii0FloB/GPnvNHa
X-Google-Smtp-Source: APXvYqzI4jqR9iyNyhx34u82QxUY8gzFu0lPcJ5OOX63KpRTO+bociYLs+S/0YC4+Cq4X/YJ9TQF2F6ragKTp4ZECcM=
X-Received: by 2002:a02:5246:: with SMTP id d67mr16691716jab.58.1566482537375;
 Thu, 22 Aug 2019 07:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
 <20190820091650.GE9855@stefanha-x1.localdomain> <CAJfpegs8fSLoUaWKhC1543Hoy9821vq8=nYZy-pw1+95+Yv4gQ@mail.gmail.com>
 <20190821160551.GD9095@stefanha-x1.localdomain> <954b5f8a-4007-f29c-f38e-dd5585879541@huawei.com>
 <CAJfpegtBYLJLWM8GJ1h66PMf2J9o38FG6udcd2hmamEEQddf5w@mail.gmail.com>
 <0e8090c7-0c7c-bcbe-af75-33054d3a3efb@huawei.com> <CAJfpegurYLAApon5Ai6Q33vEy+GPxtOTUwDCCbJ2JAbg4csDSg@mail.gmail.com>
 <a19866be-3693-648e-ee6c-8d302c830834@huawei.com> <CAOssrKd7bKts2tCAZaXLJt+BVoQtqWoJV6HfT76-qxg7W4g9PQ@mail.gmail.com>
In-Reply-To: <CAOssrKd7bKts2tCAZaXLJt+BVoQtqWoJV6HfT76-qxg7W4g9PQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 22 Aug 2019 16:02:06 +0200
Message-ID: <CAJfpegt574w1Rzge-59-1dRVtfPgCrFuCpJ5DjLQwSWg+G3ArA@mail.gmail.com>
Subject: Re: [Virtio-fs] [QUESTION] A performance problem for buffer write
 compared with 9p
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     wangyan <wangyan122@huawei.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>
Content-Type: multipart/mixed; boundary="0000000000003042650590b5237e"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000003042650590b5237e
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 22, 2019 at 3:30 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Thu, Aug 22, 2019 at 3:18 PM wangyan <wangyan122@huawei.com> wrote:
>
> > I used these commands:
> > virtiofsd cmd:
> >         ./virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o source=/mnt/share/
> > -o cache=always -o writeback
> > mount cmd:
> >         mount -t virtio_fs myfs /mnt/virtiofs -o
> > rootmode=040000,user_id=0,group_id=0
>
> Good.
>
> I think I got it now, updated patch attached.
>
> Thanks for your patience!
>
> Miklos

Previous one was broken as well.   I hope this one works...

--0000000000003042650590b5237e
Content-Type: text/x-patch; charset="US-ASCII"; name="virtio-fs-nostrict-v3.patch"
Content-Disposition: attachment; filename="virtio-fs-nostrict-v3.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jzmr81lb0>
X-Attachment-Id: f_jzmr81lb0

LS0tCiBmcy9mdXNlL3ZpcnRpb19mcy5jIHwgICAgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspCgotLS0gYS9mcy9mdXNlL3ZpcnRpb19mcy5jCisrKyBiL2ZzL2Z1c2Uvdmly
dGlvX2ZzLmMKQEAgLTg5MSw2ICs4OTEsMTAgQEAgc3RhdGljIGludCB2aXJ0aW9fZnNfZmlsbF9z
dXBlcihzdHJ1Y3QgcwogCWlmIChlcnIgPCAwKQogCQlnb3RvIGVycl9mcmVlX2luaXRfcmVxOwog
CisJLyogTm8gc3RyaWN0IGFjY291bnRpbmcgbmVlZGVkIGZvciB2aXJ0aW8tZnMgKi8KKwlzYi0+
c19iZGktPmNhcGFiaWxpdGllcyA9IEJESV9DQVBfTk9fQUNDVF9XQjsKKwliZGlfc2V0X21heF9y
YXRpbyhzYi0+c19iZGksIDEwMCk7CisKIAlmYyA9IGZzLT52cXNbVlFfUkVRVUVTVF0uZnVkLT5m
YzsKIAogCS8qIFRPRE8gdGFrZSBmdXNlX211dGV4IGFyb3VuZCB0aGlzIGxvb3A/ICovCg==
--0000000000003042650590b5237e--
