Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5446269A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfEVSNc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 14:13:32 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:55719 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVSNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 14:13:32 -0400
Received: by mail-qt1-f201.google.com with SMTP id v16so2803858qtk.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KM7CjYDnjAV8QyJ0hTISAOThnGytkQzTdcUAPgNxHfM=;
        b=Y5z/WrwYn/EevSOX0UJiI3pTm79+b38nXRuQIjSPRPPtZoTDiPsMytdq7iob9D0w9f
         iwsOjb0GO+qtEvuwjAadHLu376vLFtF6HtMYNozmhqgLwhqLHOSR3U+obcwfGbrmT/Fp
         yypOW2Z+nnGpFLTcfP4VyrVUblTXsqpA16cINoxGQLweOo14VP9C6qijmh6zSzAdFnxC
         gekeZeeHYml7yXaozy4Ty9OGvakpv4A+yc6NvPlndPIEKEDfL5uCXSc7gxM8V3bSIRXR
         484qlx/LOcBFhwYzLlczMtjo9qs4id3CpE8tx0OpumdNQz75mFWypb9kCLWEjbQG1iww
         k3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KM7CjYDnjAV8QyJ0hTISAOThnGytkQzTdcUAPgNxHfM=;
        b=m8jyYtWnsEBZrpuCNriIRbfrwHXfz/P/SRuyI5nMCKp7XLd4sDuDhnDX67TTYiJ/dv
         qLjMG1Azpe2SHbwJbivs5sdtpSmZWxAA8sjIcZn8xSE6luUY33ZR4HaFxRCgSsNxDu3h
         Z3MhHI/hVIGHFvEInw4vTU9YvUVruQWzPjBOMgKxVQdwnMTk4Gi0hGvd20HipDhHBNOu
         H6hoRgnFV3lEpWLwpZ9TlMBSndeCG1Ov1UHio5eHCXnC9UHgRkqyoeX7DoMhfB3Zjgr6
         3tutVIIQB+HGEEzC7FXC+c/NA97vpgNMfV3TWw5XhFPQftY0rAioQ41Ge/R1khjiBcKE
         fUeQ==
X-Gm-Message-State: APjAAAXJIIKYdLxP0EJE57OVgUG/Kf/iRw7LyJmqn8JhCNcxGJMDiuJg
        OKmM0+3DjrqT0NW7jlyKhGY40bH0QoPbQi+ahtJo8A==
X-Google-Smtp-Source: APXvYqxN9lF7zFmmORjY6HkdCGmVz+pn4sDp4LmILIpJctBkILss9FWEm4q8eSZUPXj+yg58aSm6E1fmbC115ww68LQIUw==
X-Received: by 2002:aed:3e69:: with SMTP id m38mr75792403qtf.101.1558548811124;
 Wed, 22 May 2019 11:13:31 -0700 (PDT)
Date:   Wed, 22 May 2019 11:13:22 -0700
Message-Id: <20190522181327.71980-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V4 0/5] Allow FUSE to provide IMA hashes directly
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dropping the final patch in the series to allow independent review,
otherwise identical to V3.


