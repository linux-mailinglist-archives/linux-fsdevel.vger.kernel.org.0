Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC61D7558
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 12:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgERKjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 06:39:40 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33151 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgERKjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 06:39:39 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id CE936A0E;
        Mon, 18 May 2020 06:39:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 May 2020 06:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        a8qFxPgNXDbutBfdJc1ON1dfUT2X5u0TBiN9wBESi40=; b=2YM8ZP+h1aGr4UcI
        2I1q4GLRacLJsxwjPYfMBGUwNsyVQ1b3mzHFkVed6z2DkgdPFy8qUOTAe5ZlK6TD
        Uc4gmxz80NMt0puVliNpTzmrJWBcaAKa6U5NUBoLKBGf/U2DU1k+RodfBn1Hcxr3
        +pKUaZCB+LqBRhTLui343Tl8lI0thG8PpRQUSzSVX5WgYxvH+JF0HwLZw4Ajimp0
        6AN9uQol+Ah/hr7RGNV0NEl6QTr6Q54KbUPQqHGF1KEU1YHxSk+0y2NUo42+v0Ja
        oc9krOnCsS5bzX6k9U1thfUajk7DANRcN2RHBkPYY5JrR2QNm7dOqiDfnKxXd7ng
        gLfQSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=a8qFxPgNXDbutBfdJc1ON1dfUT2X5u0TBiN9wBESi
        40=; b=SppxqMLqw/wTD/Ug/Vw8ALf5EYHj+Wg4vxNbD04++zeI5Cu7+F2CSAX3+
        t9XW6WmFK4RMeNAMPBTsazz4KbcNRvU2bEf56i3EMlKnqHvld+Y4LYP17kQGrQHy
        G/gaw1A22Xf8F33DOIc1fetR8ieIXk0cXSAMw7KB80TL8aZSJPeUeQR8F0AX3ne9
        uBclTcf2PP60rkxfwG0Yzp8SzvOE3sYXijJkku0X1kAsJI/81q6d8PinFbJT2xP6
        Tw0THWWKWs7aWtwjh395zbSzFjjHxlFe+6O2Dl6Scl6GmgJzYiXuujItGm8CDSbi
        I7jhEhke+cUB3IcLwo7x6G1JysRQg==
X-ME-Sender: <xms:6WXCXqCxhONOyjc44TadG1xWjY6qX6AWr_UC7YgEtsz3EvZ2Cqgmag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddukedrvddtkedrudekiedrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:6WXCXkh9i97kfvRtkpDF_9rH06DzPJGSx7SIM4dkPTanG02EzsCpcQ>
    <xmx:6WXCXtlfs_ki9QX2lkkhWVzaPzmJgbXxrNete6jIu3bZxKJlre_D8w>
    <xmx:6WXCXowxbEgamdJINV1NFjTGzeEDUEEa7J9w-UCR6pCEBXlb0kqz3A>
    <xmx:6mXCXmJiS8GSM2MTPsmesspSQ__-0ebk7ZutOYoOTv63vuhe-WvrqQ>
Received: from mickey.themaw.net (unknown [118.208.186.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06A4030663F6;
        Mon, 18 May 2020 06:39:34 -0400 (EDT)
Message-ID: <cd4f03a3820195cddeb489e66892c3d5e13b8b48.camel@themaw.net>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
From:   Ian Kent <raven@themaw.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chengguang Xu <cgxu519@mykernel.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Date:   Mon, 18 May 2020 18:39:31 +0800
In-Reply-To: <cfc4e94f6667eabee664b63cc23051e9d816456c.camel@themaw.net>
References: <20200515072047.31454-1-cgxu519@mykernel.net>
         <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
         <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
         <cfc4e94f6667eabee664b63cc23051e9d816456c.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-05-18 at 18:26 +0800, Ian Kent wrote:
> 
> Now d_splice_alias() is pretty complicated but, if passed a NULL
> dentry it amounts to calling __d_add(dentry, NULL) which produces
> a negative hashed dentry, a decision made by ext4 ->lookup() (and
> I must say typical of the very few ways such dentries get into
> the dcache).

Oh, rather that's a NULL inode not dentry.

Ian

