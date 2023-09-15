Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09A17A14A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 06:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjIOEEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 00:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjIOEEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:04:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23592710;
        Thu, 14 Sep 2023 21:03:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-564b6276941so1354196a12.3;
        Thu, 14 Sep 2023 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694750639; x=1695355439; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+ZIL8vxkKury4gaJX7IxLzJ7K795bJGx8CLgfM6pGQ=;
        b=GZFalzEc/M+1zhwSClavF8aDmdfAH3p2W5sk0C8Td7K92uFCGe1aLAPuX3jlms0ybh
         MW/ls7i2eUIXWzHbh3cAwseRA1oad0wmjeeC2nywCBAooT5MvJAyOzVB3DWWejXnvzAe
         i/mT69N24E7BgaUapAwUjhMhhsMDdfOzRE8IyJMiiwRDbfYtISkjhwKrqeoaMqnt2ItM
         jwGxKWYSI8zr5352r+FiOsne0bAKAXvYgIx8OpodOqA0vrmafwaXem0QPgUmBpnj0d7F
         PBLZBOUC8FGtUNPfeXQm4rl+IkymZcTpmsS/AHiJiNXPujduri/CCwLjWkCqxvZzWkWX
         T03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750639; x=1695355439;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+ZIL8vxkKury4gaJX7IxLzJ7K795bJGx8CLgfM6pGQ=;
        b=ott/+yZF7O4xUEBqi7MuZ54o+UXBB9adb/1V7AAnbhJuP7Kzm2P2ZueJDNmnjFKedx
         RvJnTFXIeW7BMlMyRbKkprb7r4EjTJ3buykylFRgHGYdX/ZtVa04aunC1HwLtJ+Tq7KY
         cJLblwLXEwnopuicX7qShPvDaezjF7isLfo7NS1kJX3Cf63Oejhm59EAL/eufsIoek8i
         UdmF3OQ5Ccx+2k1t/50qpfb4DC56N5E/0umANsRLMzo4sEw7KNt3q5I/zueM/D21l9+y
         wN97kICRK+f4aFX3xSfzoRggGgrvkiTQGAtlFVh/3PtJIZQ+g7eYg8VzMVZD9bI3JARL
         FmTA==
X-Gm-Message-State: AOJu0Yy+v7Mh4puC2HSOHO6H18bbRCdyhEKKLsjKbmrEpX9CT3gz8t38
        vCL4JWKR+J8B0j8IayrbcOM=
X-Google-Smtp-Source: AGHT+IEZp04o2gCMuvK4o4hL6liWFm8iNM2Qd7x8YnSj4zycDj4ibf1Z6UVzaQXW3E3B1ED9FNVXbA==
X-Received: by 2002:a05:6a21:819b:b0:11d:4c79:90ee with SMTP id pd27-20020a056a21819b00b0011d4c7990eemr631536pzb.25.1694750638999;
        Thu, 14 Sep 2023 21:03:58 -0700 (PDT)
Received: from smtpclient.apple (c-73-162-233-46.hsd1.ca.comcast.net. [73.162.233.46])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b001c0c79b386esm2373948plh.95.2023.09.14.21.03.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 21:03:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAJuCfpGWkzDUL4+9evD-Kx5uGoc+=g808CXtc1hrSUdCRMtRgA@mail.gmail.com>
Date:   Thu, 14 Sep 2023 21:03:45 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>, lokeshgidra@google.com,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, mhocko@suse.com,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Liam.Howlett@oracle.com,
        Jann Horn <jannh@google.com>, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C04B3D0F-A757-49A5-9CF4-3387EED41562@gmail.com>
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-3-surenb@google.com>
 <4F9BBE45-22D0-4F8D-BA56-CA3459998DC4@gmail.com>
 <CAJuCfpGWkzDUL4+9evD-Kx5uGoc+=g808CXtc1hrSUdCRMtRgA@mail.gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 14, 2023, at 8:28 PM, Suren Baghdasaryan <surenb@google.com> =
wrote:
>=20
> On Thu, Sep 14, 2023 at 2:57=E2=80=AFPM Nadav Amit =
<nadav.amit@gmail.com> wrote:
>>=20
>>=20
>>> On Sep 14, 2023, at 8:26 AM, Suren Baghdasaryan <surenb@google.com> =
wrote:
>>>=20
>>> +     if (!pte_same(ptep_clear_flush(src_vma, src_addr, src_pte),
>>> +             orig_src_pte))
>>> +             BUG_ON(1);
>>=20
>> Just a minor detail regarding these few lines:
>>=20
>> Besides the less-than-ideal use of BUG_ON() here, I think that this =
code
>> assumes that the PTE cannot change at this point. However, as the PTE =
was
>> still mapped at this point, I think the access and dirty bits can be =
set.
>=20
> At this point we are holding PTLs for both PTEs (see
> double_pt_lock()).  Can a PTE be modified from under us in this
> situation?

PTEs has several parts: access-control bits (e.g., writable), physical
frame number, software-only bits and log-bits. The log-bits, which are
=E2=80=9Caccess=E2=80=9D and =E2=80=9Cdirty=E2=80=9D on x86, track =
whether the PTE has ever been used
for translation or write correspondingly.

Without getting into all the subtleties (e.g., =E2=80=9Caccess" can be =
set
speculatively even if no actual access take place), as long as the PTE
is present, it might be used for access (and write if it is writable)
by other cores. The page-table locks are irrelevant here, because the
PTE is not updated by software, but it is updated by the CPU itself
during the page-walk/write.

