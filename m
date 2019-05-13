Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89791BD60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfEMSrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 14:47:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39278 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfEMSrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 14:47:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id z128so8693728qkb.6;
        Mon, 13 May 2019 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fcj7AotgrHgaGk9eGLmWk2zeSnn906Cpfa2iryM3DoI=;
        b=SQuY2s+gOhhvRTsfAUBFH8LblnHzjFKVtQhD/ihRPsOB1DqyVzD7Xi9YbAmZb4Pvhp
         kKP0V+5w7UIAUrpkSD9JLaZbwAXLCTHvW7eaQ/mEMTNGQB40/4n8tgbWfXZ/4G2zW6Ds
         7E2h7E2DbLtKiFnN7K8LldVs7Hr00QujeCB/kKbDgjKuBjhTwnW+JBdrQm7JYY24v8RT
         Tw7OIi/fi6263Hsrvk66MGEe7JsiyomynLBElEePKLWgjiQrw0eMU/E+u06hTFjxo6sb
         Fqs08/Wd3j+ANlJUFbuqQHK0gbt7dVAKrvbS1KTWyBLhqFsLmeK7omiu8V5RLxEgjWe3
         6WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fcj7AotgrHgaGk9eGLmWk2zeSnn906Cpfa2iryM3DoI=;
        b=V4Qv5paOiCPG1ZORRwNyz11OuemVxy5uQ77xsV/rKlLqRGSsRP3pp7N7ZhNC1TMwCl
         qaXThQ3ZGUa+vNuF9Em8c3ucTt4t53bNzhYOIW3ZIzvR4M9oVErrVSjvf4uaSsbGXX0j
         DN5fx/1f5ff1AhksCFxx4ngD53OLntg60RjiwI1FFUAcjklwo8OYShJuPrFLNw9aMU6c
         9fwdjaIw/ASkTSzpwVt359k2L6f9dUIhNG+mWbDLmoxy39TFlqLS+afQB7utSCtJk/sU
         VxH9O5WOpfftQZpdwz2yuft9Vt4/TB40P9YwAwiZ7lY50YnbfT3/bi+RWxcJXYnETDoW
         tUIw==
X-Gm-Message-State: APjAAAUWhSzqqMr0kldpy9QNgW0kI+S4fsk0qNimFmnYzUnV9m20aWt2
        WmQj2sWMREo0RrS+VLrjVdE=
X-Google-Smtp-Source: APXvYqwdSDAkgQrSSL+3vDaE++UoYG/GcBJoF1ZeHnppvHfcB33cgnOZ30ylcxoJS9xjNysAaeQyLg==
X-Received: by 2002:a05:620a:16b4:: with SMTP id s20mr23939911qkj.34.1557773267186;
        Mon, 13 May 2019 11:47:47 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x6sm553163qti.88.2019.05.13.11.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 11:47:46 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 May 2019 14:47:45 -0400
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Arvind Sankar <niveditas98@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
Message-ID: <20190513184744.GA12386@rani.riverdale.lan>
References: <dca50ee1-62d8-2256-6fdb-9a786e6cea5a@landley.net>
 <20190512194322.GA71658@rani.riverdale.lan>
 <3fe0e74b-19ca-6081-3afe-e05921b1bfe6@huawei.com>
 <4f522e28-29c8-5930-5d90-e0086b503613@landley.net>
 <f7bc547c-61f4-1a17-735c-7e8df97d7965@huawei.com>
 <20190513172007.GA69717@rani.riverdale.lan>
 <20190513175250.GC69717@rani.riverdale.lan>
 <1557772584.4969.62.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1557772584.4969.62.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 13, 2019 at 02:36:24PM -0400, Mimi Zohar wrote:
> 
> > > How does this work today then? Is it actually the case that initramfs
> > > just cannot be used on an IMA-enabled system, or it can but it leaves
> > > the initramfs unverified and we're trying to fix that? I had assumed the
> > > latter.
> > Oooh, it's done not by starting IMA appraisal later, but by loading a
> > default policy to ignore initramfs?
> 
> Right, when rootfs is a tmpfs filesystem, it supports xattrs, allowing
> for finer grained policies to be defined.  This patch set would allow
> a builtin IMA appraise policy to be defined which includes tmpfs.
> 
> Mimi
> 
Ok, but wouldn't my idea still work? Leave the default compiled-in
policy set to not appraise initramfs. The embedded /init sets all the
xattrs, changes the policy to appraise tmpfs, and then exec's the real
init? Then everything except the embedded /init and the file with the
xattrs will be appraised, and the embedded /init was verified as part of
the kernel image signature. The only additional kernel change needed
then is to add a config option to the kernel to disallow overwriting the
embedded initramfs (or at least the embedded /init).
