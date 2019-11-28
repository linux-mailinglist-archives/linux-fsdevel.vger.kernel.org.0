Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0045110CCA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfK1QSp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 11:18:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35021 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1QSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:18:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id s5so31802779wrw.2;
        Thu, 28 Nov 2019 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to:return-receipt-to;
        bh=ohBjHOyOnFlrxMH2Rt30HL4xfTA08VtelHXmjZGxoRA=;
        b=lP45t5/BhQY+6M3Ul+U/X+q7zmz5LyiLRZ3T6rLg/yR/kdeaJK2o1szZtbT5u3CjMm
         PLUxVplAQlJuC2lGsJKi87YCrj5juAyFCoGCwxh+zh3cMZQm+Z9G5IBz+o8JGkOl/nFH
         sv/WnAlEiKlbYCIhtbQhknR4qWoFVUq3Q2xTj9U6CTiuSJ/+tuZt9mXV4h1E+qOCxEqA
         Y+HxxIS+97+NW1OJpwJU9goqQlKBIXgOnGONQG5zgWzWfJ1cbTmI4ZsjG7nE89CbLRgr
         ImrKgGm6fKRR4/OrJIcbaOHtbaNydwgo0th59AQp2kuffSNe6X0qIljty+ijm/IyeTdH
         qcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to:return-receipt-to;
        bh=ohBjHOyOnFlrxMH2Rt30HL4xfTA08VtelHXmjZGxoRA=;
        b=pT8S82AfgK+A83d1UGmFc9FW9WUZ5fnTatPbnaz5502aXB97zAV3qdNX0TJyuM2yc0
         +5Fc+QkNGg3rIzLVR+cBmkx1qa0GToziR2ZwoFUQA58nUqK31qnr4gA1rvmYQGV+YGX9
         ARIHPiZqGcR41+mJ2/J2BXfyWvUZi48s/b6T6uXbrzSHPLLrxgIOiMMeKZwQrxkVj4mP
         5rjKpOuz914niM/vfE5lw4X8Gql6qzv2jTD41V61/rBlA1SaQSbtCEt4Wt+flOI/qKL3
         PGfYzaJOwRrT1qUod7yH1npIs3nX4bVRdtr0bpnmrmGEPKdyst7j0I/FjppgWTjfv4Dz
         gFcg==
X-Gm-Message-State: APjAAAXgpXzLZM36g4pn/JwdljGE6UEi6TmZBWrgoAC6kPWusPswVtPl
        PTlw1GCtGAuZ5rQsoOJOLQk=
X-Google-Smtp-Source: APXvYqzZHYztEpmnt1F71ropqcrCwqlMHNN68TUHfTTT5h1FYelZ+kZ6RN+dZ5YfpIYZh6DZ25tE+Q==
X-Received: by 2002:adf:9f43:: with SMTP id f3mr49515621wrg.76.1574957923557;
        Thu, 28 Nov 2019 08:18:43 -0800 (PST)
Received: from LENOVO-PC.Home ([196.170.212.60])
        by smtp.gmail.com with ESMTPSA id e18sm2544887wrr.95.2019.11.28.08.18.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 08:18:42 -0800 (PST)
Message-ID: <5ddff362.1c69fb81.3eff1.cfc8@mx.google.com>
From:   Katie Higgins <helms684@gmail.com>
X-Google-Original-From: Katie Higgins
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: 
To:     Recipients <Katie@vger.kernel.org>
Date:   Thu, 28 Nov 2019 16:18:26 +0000
Reply-To: katiehiggins143@gmail.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

j=F3 napot, k=E9rlek besz=E9lhet=FCnk?
