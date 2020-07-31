Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DD9234456
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 12:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732606AbgGaKx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732538AbgGaKx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 06:53:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8D1C061574;
        Fri, 31 Jul 2020 03:53:55 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id q4so14610464oia.1;
        Fri, 31 Jul 2020 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=060okimkvHZHl9OWyLt7+K8yQ38XaZrF6LJc1HiWbRI=;
        b=LQ1RKR5/QC8MEg2QZqp6i+aaeb6PXil2GELlyocM6zZ0ij1q/0MLeOIFNeFzMY2dEf
         za3DCz3/qCG+UFW6Av0Kq191WAe7w0EWIvxkYD91GQpj7zfAARKuQW6PjOOaSQoojvPQ
         Ikrf62ZtRDcEnbS1dNRP7+2FSYZogNsR07iCQC3sftUz0XLAqFLwmEH3GWOc+gOrB/vC
         eLdpN3rwzrl5sZQ31OPr9JR3MjJVohDoh+vj9GxEZd6JiGcgTaD/lLB0FEggajM5R+HD
         j9gG7td7f1r6LJQLdaC9dDqo8xb3Ubqin05/JijH0JnHzyh2DuFK60IKnAGdyVyo8OW6
         pofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=060okimkvHZHl9OWyLt7+K8yQ38XaZrF6LJc1HiWbRI=;
        b=ar7oyQG4x+ipINjSqwKPHu0HWnlgjDYJl0Q5zeMpWvyMFXSNwByo+OdNH2RbUI13Z3
         ebcMcgzEE7cK9Uhre4AI8EXxMDTrqiSTvuV6Hx1Vf75SCMrzSKSU5PZ9Tih8ghyyP5FW
         AzHkbS12qNvntNPT7YA1NlyCundJeOmnMIvZMeWh8sLXvs4c9P6KLvRThkNfcpn825WI
         TSgipedZA80ZxC101/+ja4QBl60uA2sgxZ/6rN0aXCe6g/OrE0TwR+rKkYHlRoYnp4PZ
         mW8BEX6/EDYZgUmFURJrqW8NtuNTTaM2RJ7Si/oxkVvpZOpfvX2gmebeaUfqPfev0M+B
         1p9g==
X-Gm-Message-State: AOAM533bc7HYfbc/Kg+1IK5XLmvQcRxc7onew0+wVIK5KX/tza7LzAe2
        77HOfxOM36WnjnC7v5124Mia8ig9Ob96Z2qTRKB/BCawJmLbiQ==
X-Google-Smtp-Source: ABdhPJzYm4lmtPNgDZK1H1U5XHvZSIeBQoEIqs2j4MdOz2Po+vACtN/fV6WUE3kpz4FpoRxzgG1AIWfpybhOu5eHhLM=
X-Received: by 2002:a05:6808:311:: with SMTP id i17mr2614907oie.72.1596192835308;
 Fri, 31 Jul 2020 03:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200731071604epcas1p39fe86c3931c5adf9073817c12fb15f1d@epcas1p3.samsung.com>
 <002901d6670a$742e8cf0$5c8ba6d0$@samsung.com> <CA+icZUX8KWtdDpMcmzqp461ndcyfvP13gaZK591OFpkp3nRHaQ@mail.gmail.com>
In-Reply-To: <CA+icZUX8KWtdDpMcmzqp461ndcyfvP13gaZK591OFpkp3nRHaQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 31 Jul 2020 12:53:44 +0200
Message-ID: <CA+icZUWzkovf=kQcdwrGirfEkhyXHF0j4ZXf+4S3+5m+vuOJjw@mail.gmail.com>
Subject: Re: exfatprogs-1.0.4 version released
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sven Hoexter <sven@stormbind.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Luca Stefani <luca.stefani.ge1@gmail.com>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Ethan Sommer <e5ten.arch@gmail.com>,
        Hyeongseok Kim <hyeongseok@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> congrats to version 1.0.4 and hope to see it in the Debian repositories soon.
>

Thanks Sven!

root# dpkg -l | grep exfatprogs | awk '/^ii/ {print $1 " " $2 " " $3}'
| column -t
ii  exfatprogs  1.0.4-1

- Sedat -
